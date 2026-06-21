#!/usr/bin/env python3
"""
extract_kb.py - Comprehensive knowledge-base extraction from the CraftBeer
sources. Models, per style, the full parameter set from the 2017 Beer Styles
Study Guide (qualitative descriptors, palate, hop/malt, serving) and the
authoritative food pairings (cheese / entrée / dessert) from Parings.xlsx (ODS).

Outputs:
  data/beer-styles.csv   auditable comprehensive table
  clips/beer-data.clp    deftemplate beer-profile + deffacts, deftemplate pairing + deffacts

Requires `pdftotext` (poppler-utils) and the CraftBeer/ material (gitignored).
Run:  python3 scripts/extract_kb.py
"""
import csv
import html
import re
import subprocess
import sys
import unicodedata
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GUIDE = ROOT / "CraftBeer" / "Beer Styles Study Guide.pdf"
ODS = ROOT / "CraftBeer" / "Parings.xlsx"
FCT = ROOT / "clips" / "beer-styles.fct"
CSV = ROOT / "data" / "beer-styles.csv"
CLP = ROOT / "clips" / "beer-data.clp"

if not GUIDE.exists() or not ODS.exists():
    sys.exit("missing CraftBeer/ sources (gitignored); add them to regenerate")


def deglyph(s):
    s = "".join(c for c in s if not (0xE000 <= ord(c) <= 0xF8FF))
    return re.sub(r"\s+", " ", s).strip()


def norm(s):
    s = unicodedata.normalize("NFKD", s)
    s = "".join(c for c in s if not unicodedata.combining(c))
    return re.sub(r"[^a-z0-9]", "", s.lower())


def q(s):  # CLIPS string literal
    return '"%s"' % s.replace("\\", "").replace('"', "'")


# -- 1. authoritative pairings from the ODS (4-column table) -----------------
def parse_ods():
    with zipfile.ZipFile(ODS) as z:
        xml = z.read("content.xml").decode("utf-8", "replace")

    def cells_of(row):  # respect empty cells and repeated-cell runs
        out = []
        for m in re.finditer(
                r"<table:table-cell([^>]*)>(.*?)</table:table-cell>"
                r"|<table:table-cell([^>]*)/>", row, re.S):
            attrs = m.group(1) or m.group(3) or ""
            rep = re.search(r'number-columns-repeated="(\d+)"', attrs)
            txt = "".join(re.findall(r"<text:p[^>]*>(.*?)</text:p>", m.group(2) or "", re.S))
            txt = html.unescape(re.sub(r"<[^>]*>", "", txt)).strip()
            n = int(rep.group(1)) if rep else 1
            if n > 20:  # trailing run of empty cells padding the row
                n = 1
            out += [txt] * n
        return out

    # parse row by row: an empty cell must NOT shift the later columns
    pairings = {}
    for row in re.findall(r"<table:table-row[^>]*>(.*?)</table:table-row>", xml, re.S):
        c = cells_of(row)
        if len(c) >= 4 and c[0] and norm(c[0]) not in ("beerstyle", ""):
            pairings[norm(c[0])] = {"style": c[0], "cheese": c[1],
                                    "entree": c[2], "dessert": c[3]}
    return pairings


# -- 2. parameters per style from the Study Guide ---------------------------
LABELS = {
    "alcohol": "Alcohol", "colour": "Color", "clarity": "Clarity",
    "country": "Country of Origin", "body": "Palate Body",
    "palate_carbonation": "Palate Carbonation", "finish": "Palate Length/Finish",
    "glass": "Glass", "hop": "Hop Aroma/Flavor", "malt": "Malt Aroma/Flavor",
    "temperature": "Temperature",
}


def parse_guide():
    txt = subprocess.run(["pdftotext", "-layout", str(GUIDE), "-"],
                         capture_output=True, text=True, errors="replace").stdout
    lines = txt.splitlines()
    fam = [i for i, l in enumerate(lines) if "Famil" in l]

    def name_above(i):
        j = i - 1
        while j >= 0 and not deglyph(lines[j]):
            j -= 1
        return deglyph(lines[j]) if j >= 0 else ""

    def field(block, label):
        # block lines are already de-glyphed (single-spaced); each A-Z field is
        # its own "Label value" line.
        m = re.search(rf"(?m)^{re.escape(label)}\s+(\S.*?)\s*$", block)
        return m.group(1).strip() if m else ""

    styles = {}
    for k, fi in enumerate(fam):
        end = fam[k + 1] if k + 1 < len(fam) else len(lines)
        block = deglyph_block = "\n".join(deglyph(l) for l in lines[fi:end])
        cut = block.find("source: CraftBeer")
        if cut != -1:
            block = block[:cut]
        rec = {key: field(block, lab) for key, lab in LABELS.items()}
        styles[norm(name_above(fi))] = rec
    return styles


def main():
    fct_names = re.findall(r'\(name "([^"]+)"', FCT.read_text(encoding="utf-8"))
    pairings = parse_ods()
    params = parse_guide()

    import difflib
    def match(target, table):
        keys = list(table)
        m = difflib.get_close_matches(norm(target), keys, n=1, cutoff=0.6)
        return table[m[0]] if m else None

    # Pairings need a stricter assignment than the parameters: the chart and the
    # fct use slightly different style names, so we (1) alias the known naming
    # gaps to their exact chart row and (2) let each chart row be claimed by at
    # most one style. Without (2) a style that is absent from the chart (e.g. a
    # sour) would borrow a near-namesake's row (American Stout); with it, the
    # exact match wins the row and the absent style is correctly left unpaired.
    PAIR_ALIASES = {"Imperial IPA": "Imperial India Pale Ale"}
    pair_for, used = {}, set()
    for name in fct_names:                       # pass 1: exact / aliased rows
        key = norm(PAIR_ALIASES.get(name, name))
        if key in pairings:
            pair_for[name] = pairings[key]
            used.add(key)
    for name in fct_names:                        # pass 2: fuzzy on what is left
        if name in pair_for:
            continue
        cand = [k for k in pairings if k not in used]
        m = difflib.get_close_matches(norm(name), cand, n=1, cutoff=0.6)
        if m:
            pair_for[name] = pairings[m[0]]
            used.add(m[0])

    cols = ["name", "cheese", "entree", "dessert", "alcohol", "colour", "clarity",
            "body", "palate_carbonation", "finish", "hop", "malt", "glass",
            "temperature", "country"]
    rows = []
    for name in fct_names:
        p = pair_for.get(name, {})
        d = match(name, params) or {}
        row = {"name": name, "cheese": p.get("cheese", ""), "entree": p.get("entree", ""),
               "dessert": p.get("dessert", "")}
        for key in LABELS:
            row[key] = d.get(key, "")
        rows.append(row)

    CSV.parent.mkdir(exist_ok=True)
    with CSV.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=cols, extrasaction="ignore")
        w.writeheader()
        for r in rows:
            w.writerow(r)

    out = ["; Auto-generated by scripts/extract_kb.py from the CraftBeer 2017 Beer",
           "; Styles Study Guide and Parings.xlsx. Comprehensive per-style profile",
           "; (descriptors, palate, hop/malt, serving) and authoritative food pairings.",
           ";", "; Author: Donato Meoli", "",
           "(deftemplate beer-profile",
           "   (slot name (type STRING))",
           "   (slot alcohol (type STRING)) (slot colour (type STRING)) (slot clarity (type STRING))",
           "   (slot body (type STRING)) (slot palate-carbonation (type STRING)) (slot finish (type STRING))",
           "   (slot hop (type STRING)) (slot malt (type STRING))",
           "   (slot glass (type STRING)) (slot temperature (type STRING)) (slot country (type STRING)))",
           "",
           "(deftemplate pairing",
           "   (slot style (type STRING)) (slot cheese (type STRING))",
           "   (slot entree (type STRING)) (slot dessert (type STRING)))", "",
           "(deffacts beer-profiles"]
    for r in rows:
        if any(r[k] for k in LABELS):
            out.append("   (beer-profile (name %s) (alcohol %s) (colour %s) (clarity %s) "
                       "(body %s) (palate-carbonation %s) (finish %s) (hop %s) (malt %s) "
                       "(glass %s) (temperature %s) (country %s))" % (
                           q(r["name"]), q(r["alcohol"]), q(r["colour"]), q(r["clarity"]),
                           q(r["body"]), q(r["palate_carbonation"]), q(r["finish"]),
                           q(r["hop"]), q(r["malt"]), q(r["glass"]), q(r["temperature"]),
                           q(r["country"])))
    out.append(")")
    out.append("")
    out.append("(deffacts beer-pairings")
    for r in rows:
        if r["cheese"] or r["entree"] or r["dessert"]:
            out.append("   (pairing (style %s) (cheese %s) (entree %s) (dessert %s))" % (
                q(r["name"]), q(r["cheese"]), q(r["entree"]), q(r["dessert"])))
    out.append(")")
    CLP.write_text("\n".join(out) + "\n")

    np = sum(1 for r in rows if r["cheese"])
    npar = sum(1 for r in rows if any(r[k] for k in LABELS))
    print(f"styles: {len(rows)}   with pairings: {np}   with parameters: {npar}")
    print(f"  -> {CSV.relative_to(ROOT)}")
    print(f"  -> {CLP.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
