;;;===========================================================================
;;; test-scoring.clp - Self-checking tests for the BeerEX fuzzy scoring backend
;;;
;;;   Run from the repo root:
;;;     clips -f tests/test-scoring.clp
;;;   (uses ~/.local/bin/clips 6.4.x; the FuzzyCLIPS submodule must be present)
;;;
;;;   Author: Donato Meoli
;;;===========================================================================

; minimal beer/attribute templates (the full ones live in clips/beerex.clp)
(deftemplate beer (slot style) (slot name) (multislot alcohol) (multislot color)
   (multislot flavor) (multislot fermentation) (multislot carbonation) (slot link))
(deftemplate attribute (slot name) (slot value) (slot certainty (default 1.0)))
(deftemplate beer-why (slot name) (slot text))
(deftemplate meal-keyword (slot text))
; i18n stubs (the real ones live in clips/beerex.clp); rationale wraps labels in (T ...)
(defglobal ?*lang* = en)
(deftemplate translation (slot en (type STRING)) (slot it (type STRING)))
(deffunction T (?s)
   (if (eq ?*lang* en) then (return ?s))
   (do-for-fact ((?t translation)) (eq ?t:en ?s) (return ?t:it))
   ?s)
(load "third_party/FuzzyCLIPS/fuzzy.clp")
(load "clips/beer-ranges.clp")
(load "clips/beer-data.clp")
(load "clips/beer-fuzzy.clp")
(reset)
(load-facts "clips/beer-styles.fct")

(defglobal ?*pass* = 0 ?*fail* = 0)

(deffunction chk (?desc ?cond)
   (if ?cond
    then (bind ?*pass* (+ ?*pass* 1)) (printout t "  PASS  " ?desc crlf)
    else (bind ?*fail* (+ ?*fail* 1)) (printout t "  FAIL  " ?desc crlf)))

(deffunction approx (?a ?b) (< (abs (- ?a ?b)) 0.001))

(deffunction clear-prefs ()
   (do-for-all-facts ((?d desire)) TRUE (retract ?d))
   (do-for-all-facts ((?c desire-cat)) TRUE (retract ?c))
   (do-for-all-facts ((?s suggest-name)) TRUE (retract ?s))
   (do-for-all-facts ((?s suggest-style)) TRUE (retract ?s))
   (do-for-all-facts ((?k meal-keyword)) TRUE (retract ?k))
   (do-for-all-facts ((?a attribute)) TRUE (retract ?a)))

(deffunction run-tests ()
   (printout t crlf "=== fuzzy scoring tests ===" crlf)

   ; 1. "pale" ranks a pale beer first
   (assert (desire (axis color) (term pale) (weight 1.0)))
   (bind ?top (nth$ 1 (beer-rank 1)))
   (chk (str-cat "pale -> top is pale (" ?top ")")
        (eq (beer-classify color (beer-axis-value ?top srm)) pale))
   (clear-prefs)

   ; 2. "dark" ranks a dark beer first
   (assert (desire (axis color) (term dark) (weight 1.0)))
   (bind ?top (nth$ 1 (beer-rank 1)))
   (chk (str-cat "dark -> top is dark (" ?top ")")
        (eq (beer-classify color (beer-axis-value ?top srm)) dark))
   (clear-prefs)

   ; 3. high bitterness: Imperial IPA fully satisfies it
   (assert (desire (axis bitterness) (term high) (weight 1.0)))
   (chk "bitterness=high -> Imperial IPA scores 1.0" (approx (beer-score "Imperial IPA") 1.0))
   (clear-prefs)

   ; 4. worked example: pale(.8)+bitter(.6) -> exact scores, Pilsener beats Imperial IPA
   (assert (desire (axis color) (term pale) (weight 0.8)))
   (assert (desire (axis bitterness) (term high) (weight 0.6)))
   (chk "pale+bitter: German Pilsener = 0.7857" (approx (beer-score "German-Style Pilsener") 0.785714))
   (chk "pale+bitter: Imperial IPA = 0.4286"     (approx (beer-score "Imperial IPA") 0.428571))
   (chk "pale+bitter: Pilsener > Imperial IPA"
        (> (beer-score "German-Style Pilsener") (beer-score "Imperial IPA")))
   (clear-prefs)

   ; 5. catch-all styles are not rewarded (Honey Beer has no characteristic axis)
   (assert (desire (axis color) (term pale) (weight 1.0)))
   (chk "catch-all Honey Beer scores 0 on pale" (approx (beer-score "Honey Beer") 0.0))
   (clear-prefs)

   ; 6. a direct suggestion boosts the suggested beer
   (assert (desire (axis color) (term pale) (weight 0.8)))
   (bind ?without (beer-score "American Imperial Stout"))
   (assert (suggest-name (name "American Imperial Stout") (weight 0.9)))
   (bind ?with (beer-score "American Imperial Stout"))
   (chk "suggestion boosts Imperial Stout" (> ?with ?without))
   (clear-prefs)

   ; 7. categorical desire (desire-cat) on the flavor slot
   (assert (desire-cat (slot flavor) (value malty-sweet) (weight 1.0)))
   (chk "desire-cat: Doppelbock (malty) = 1.0" (approx (beer-score "German-Style Doppelbock") 1.0))
   (chk "desire-cat: American IPA (not malty) = 0.0" (approx (beer-score "American IPA") 0.0))
   (clear-prefs)

   ; 8. CF->fuzzy bridge: best-* attributes -> ranked beer attributes
   (assert (attribute (name best-color) (value pale) (certainty 0.8)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 0.9)))
   (beer-generate-fuzzy 79)
   (chk "bridge produced beer attributes"
        (> (length$ (find-all-facts ((?a attribute)) (eq ?a:name beer))) 0))
   (chk "bridge includes the suggested German Pilsener"
        (> (length$ (find-all-facts ((?a attribute))
              (and (eq ?a:name beer) (neq (str-index "German-Style Pilsener" ?a:value) FALSE)))) 0))
   (clear-prefs)

   ; 9. CraftBeer pairings + serving info (comprehensive KB)
   (assert (meal-keyword (text Cheddar)))
   (chk "pairing-bonus: American Amber Ale pairs with Cheddar"
        (approx (pairing-bonus "American Amber Ale") 1.0))
   (chk "pairing-bonus: Imperial IPA does not pair with Cheddar"
        (approx (pairing-bonus "Imperial IPA") 0.0))
   (chk "serving-info includes a temperature" (neq (str-index "🌡" (serving-info "American Amber Ale")) FALSE))
   (bind ?with (beer-score "American Amber Ale"))
   (clear-prefs)
   (bind ?without (beer-score "American Amber Ale"))
   (chk "a named food boosts a beer paired with it" (> ?with ?without))

   (printout t crlf "SCORING PASS=" ?*pass* " FAIL=" ?*fail* crlf))

(run-tests)
(exit)
