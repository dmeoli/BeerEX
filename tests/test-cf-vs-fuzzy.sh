#!/usr/bin/env bash
#
# test-cf-vs-fuzzy.sh - Drives the real BeerEX selection rules end-to-end with a
# fixed profile, once per backend (cf | fuzzy), and shows the recommended beers.
# The dialog rules are removed so we can inject a controlled end-state; the
# knowledge rules' output (best-* attributes) is supplied directly.
#
# Requires CLIPS 6.4.x (set $CLIPS) and the FuzzyCLIPS submodule.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLIPS="${CLIPS:-$HOME/.local/bin/clips}"
cd "$ROOT"

run_backend() { # backend
  cat > /tmp/_cmp.clp <<EOF
(load "clips/beerex.clp")
(load "third_party/FuzzyCLIPS/fuzzy.clp")
(load "clips/beer-ranges.clp")
(load "clips/beer-data.clp")
(load "clips/beer-fuzzy.clp")
(load "clips/beerex-fuzzy.clp")
(undefrule load-beer-question-rules)
(undefrule load-beer-knowledge-rules)
(undefrule load-beer-styles-list)
(undefrule start)
(reset)
(load-facts "clips/beer-styles.fct")
(bind ?*backend* $1)
(assert (UI-state (id s1) (state middle)))
(do-for-fact ((?s state-list)) TRUE (modify ?s (current s1) (sequence s1)))
; fixed profile (what the knowledge base would assert): prefer pale + bitter,
; with a direct meal pairing suggestion for American IPA.
(assert (attribute (name best-color)  (value pale)        (certainty 0.2)))
(assert (attribute (name best-flavor) (value hoppy-bitter)(certainty 0.2)))
(assert (attribute (name best-name)   (value "American IPA") (certainty 0.9)))
(run)
(do-for-fact ((?u UI-state)) (and (eq ?u:state final) (neq (str-index "selected" ?u:display) FALSE))
   (printout t ?u:display crlf))
(exit)
EOF
  "$CLIPS" -f /tmp/_cmp.clp 2>/dev/null | grep -E '🍺|μ|•|Done|Sorry' | sed 's/(www[^)]*)//g; s/(http[^)]*)//g'
}

pass=0; fail=0
chk() { if eval "$2"; then echo "  PASS  $1"; pass=$((pass+1)); else echo "  FAIL  $1"; fail=$((fail+1)); fi; }

echo "=== CF backend ==="
cf="$(run_backend cf)"; echo "$cf"
echo "=== FUZZY backend ==="
fz="$(run_backend fuzzy)"; echo "$fz"
echo
chk "CF produced recommendations"     'echo "$cf" | grep -q "🍺"'
chk "FUZZY produced recommendations"  'echo "$fz" | grep -q "🍺"'
chk "CF list includes American IPA (suggested)"    'echo "$cf" | grep -q "American IPA"'
chk "FUZZY list includes American IPA (suggested)" 'echo "$fz" | grep -q "American IPA"'
chk "FUZZY shows data-grounded explanation (μ)"    'echo "$fz" | grep -q "μ"'
chk "FUZZY explanation has per-beer rationale"     'echo "$fz" | grep -q "•"'
echo
echo "PASS=$pass FAIL=$fail"
[ $fail -eq 0 ]
