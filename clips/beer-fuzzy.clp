;;;===========================================================================
;;; beer-fuzzy.clp - Fuzzy backend for BeerEX
;;;
;;;   Linguistic variables for the measurable beer attributes, with membership
;;;   functions whose breakpoints are DERIVED FROM DATA (the CraftBeer 2017
;;;   Beer Styles Guide numeric ranges, see scripts/extract_ranges.py and
;;;   data/beer-style-ranges.csv) rather than hand-assigned certainty factors.
;;;
;;;   Axes:
;;;     color       <- SRM   (pale / amber / brown / dark)
;;;     alcohol     <- ABV %  (not-detectable / mild / noticeable / harsh)
;;;     bitterness  <- IBU   (low / medium / high)        [new objective axis]
;;;   Carbonation stays symbolic: the guide's CO2 volumes do not separate
;;;   medium from high, so a data-driven MF is not justified.
;;;
;;;   Requires the FuzzyCLIPS library to be loaded first:
;;;     (load "third_party/FuzzyCLIPS/fuzzy.clp")
;;;
;;;   Author: Donato Meoli
;;;===========================================================================

;;****************
;;* DEFTEMPLATES *
;;****************

;; A trapezoidal membership function a<=b<=c<=d on a named axis/term.
;; rises 0->1 over [a,b], =1 over [b,c], falls 1->0 over [c,d].
;; a==b => left shoulder (full at the bottom of the universe);
;; c==d => right shoulder (full at the top).
(deftemplate ling-term
   (slot axis)
   (slot term)
   (slot a) (slot b) (slot c) (slot d))

(deftemplate ling-var
   (slot axis)
   (slot from)
   (slot to))

;;************
;;* DEFFACTS *
;;************

(deffacts beer-linguistic-variables
   (ling-var (axis color)      (from 0) (to 50))
   (ling-var (axis alcohol)    (from 2) (to 15))
   (ling-var (axis bitterness) (from 0) (to 70)))

;; Breakpoints validated against the data distributions (p25/median/p75).
(deffacts beer-linguistic-terms
   ; color <- SRM
   (ling-term (axis color) (term pale)  (a 0)  (b 0)  (c 6)  (d 9))
   (ling-term (axis color) (term amber) (a 6)  (b 9)  (c 11) (d 14))
   (ling-term (axis color) (term brown) (a 11) (b 14) (c 21) (d 27))
   (ling-term (axis color) (term dark)  (a 21) (b 27) (c 50) (d 50))
   ; alcohol <- ABV %  (not-detectable/mild deliberately overlap: ABV ~ perceived)
   (ling-term (axis alcohol) (term not-detectable) (a 2)   (b 2)   (c 4.5) (d 5.2))
   (ling-term (axis alcohol) (term mild)           (a 4.5) (b 5.0) (c 6.0) (d 6.6))
   (ling-term (axis alcohol) (term noticeable)     (a 6.0) (b 6.6) (c 8.0) (d 8.6))
   (ling-term (axis alcohol) (term harsh)          (a 8.0) (b 8.6) (c 15)  (d 15))
   ; bitterness <- IBU
   (ling-term (axis bitterness) (term low)    (a 0)  (b 0)  (c 20) (d 25))
   (ling-term (axis bitterness) (term medium) (a 20) (b 25) (c 30) (d 35))
   (ling-term (axis bitterness) (term high)   (a 30) (b 35) (c 70) (d 70)))

;;****************
;;* DEFFUNCTIONS *
;;****************

;; Trapezoid membership at ?x, building the right coordinate pairs and handling
;; left/right shoulders. Relies on fuzzy-eval from fuzzy.clp.
(deffunction beer-mf (?a ?b ?c ?d ?x)
   (bind ?xs (create$))
   (bind ?ys (create$))
   (if (< ?a ?b) then (bind ?xs (create$ ?xs ?a)) (bind ?ys (create$ ?ys 0.0)))
   (bind ?xs (create$ ?xs ?b ?c))
   (bind ?ys (create$ ?ys 1.0 1.0))
   (if (< ?c ?d) then (bind ?xs (create$ ?xs ?d)) (bind ?ys (create$ ?ys 0.0)))
   (fuzzy-eval ?xs ?ys ?x))

;; Membership of crisp ?x in a single (axis, term).
(deffunction beer-membership (?axis ?term ?x)
   (do-for-fact ((?t ling-term)) (and (eq ?t:axis ?axis) (eq ?t:term ?term))
      (return (beer-mf ?t:a ?t:b ?t:c ?t:d ?x)))
   0.0)

;; Best-matching term for crisp ?x on an axis (the "linguistic" reading).
(deffunction beer-classify (?axis ?x)
   (bind ?best none) (bind ?bestmu -1.0)
   (do-for-all-facts ((?t ling-term)) (eq ?t:axis ?axis)
      (bind ?mu (beer-mf ?t:a ?t:b ?t:c ?t:d ?x))
      (if (> ?mu ?bestmu) then (bind ?bestmu ?mu) (bind ?best ?t:term)))
   ?best)

;; Midpoint of a beer's numeric range on an axis, from the beer-range facts
;; (clips/beer-ranges.clp). ?slot is abv | ibu | srm | og | fg | co2.
(deffunction beer-axis-value (?name ?slot)
   (do-for-fact ((?b beer-range)) (eq ?b:name ?name)
      (bind ?r (fact-slot-value ?b ?slot))
      (if (> (length$ ?r) 0)
       then (return (/ (+ (nth$ 1 ?r) (nth$ (length$ ?r) ?r)) 2))))
   FALSE)

;;********************
;;* SCORING & RANKING *
;;********************
;; The desired profile (asserted by the knowledge rules in fuzzy mode):
;;   continuous axes -> (desire (axis ..) (term ..) (weight w))   w in [-1,1]
;;   categorical flavor -> (desire-flavor (value ..) (weight w))
;;   direct pairing -> (suggest-name "..") / (suggest-style "..") with a weight
;; Beer score = sum(w * match) / sum(|w|)  (normalised weighted mean).

(deftemplate desire        (slot axis) (slot term) (slot weight (default 1.0)))
(deftemplate desire-cat    (slot slot) (slot value) (slot weight (default 1.0)))
(deftemplate suggest-name  (slot name) (slot weight (default 1.0)))
(deftemplate suggest-style (slot style) (slot weight (default 1.0)))

;; axis -> the beer-range slot that measures it
(deffunction beer-axis-slot (?axis)
   (if (eq ?axis color)      then (return srm))
   (if (eq ?axis alcohol)    then (return abv))
   (if (eq ?axis bitterness) then (return ibu))
   nil)

;; Does beer ?name carry ?value in its symbolic multislot ?slot (flavor, carbonation, ...)?
(deffunction beer-has-cat (?name ?slot ?value)
   (do-for-fact ((?b beer)) (eq ?b:name ?name)
      (return (neq (member$ ?value (fact-slot-value ?b ?slot)) FALSE)))
   FALSE)

(deffunction beer-style-of (?name)
   (do-for-fact ((?b beer)) (eq ?b:name ?name) (return ?b:style))
   nil)

;; --- CraftBeer profile & pairing helpers (data in clips/beer-data.clp) -----
(deffunction beer-profile-slot (?name ?slot)
   (do-for-fact ((?p beer-profile)) (eq ?p:name ?name) (return (fact-slot-value ?p ?slot)))
   "")

;; Short serving hint (temperature, glass) appended to a recommendation line.
(deffunction serving-info (?name)
   (bind ?t (beer-profile-slot ?name temperature))
   (bind ?g (beer-profile-slot ?name glass))
   (if (and (eq ?t "") (eq ?g "")) then (return ""))
   (str-cat " — 🌡 " ?t " · 🥃 " ?g))

;; 1.0 if any food the user mentioned (meal-keyword) appears in this style's
;; authoritative CraftBeer pairing (cheese/entree/dessert), else 0.0.
(deffunction pairing-bonus (?name)
   (bind ?hit 0.0)
   (do-for-fact ((?p pairing)) (eq ?p:style ?name)
      (bind ?txt (lowcase (str-cat ?p:cheese " " ?p:entree " " ?p:dessert)))
      (do-for-all-facts ((?k meal-keyword)) TRUE
         (bind ?w (lowcase (str-cat "" ?k:text)))
         (if (and (> (str-length ?w) 2) (neq (str-index ?w ?txt) FALSE))
          then (bind ?hit 1.0))))
   ?hit)

;; Normalised weighted-mean satisfaction score of beer ?name vs the desires
;; currently in working memory. Returns a value in ~[-1,1].
(deffunction beer-score (?name)
   (bind ?num 0.0)
   (bind ?den 0.0)
   ; continuous axis desires (data-grounded membership). The weight always counts
   ; toward the denominator: a beer with no measured value on a desired axis is
   ; penalised (contributes 0), not exempted.
   (do-for-all-facts ((?d desire)) TRUE
      (bind ?slot (beer-axis-slot ?d:axis))
      (bind ?x (beer-axis-value ?name ?slot))
      (bind ?num (+ ?num (* ?d:weight (if (neq ?x FALSE)
                                        then (beer-membership ?d:axis ?d:term ?x)
                                        else 0.0))))
      (bind ?den (+ ?den (abs ?d:weight))))
   ; categorical desires (flavor, carbonation, ...)
   (do-for-all-facts ((?c desire-cat)) TRUE
      (bind ?num (+ ?num (* ?c:weight (if (beer-has-cat ?name ?c:slot ?c:value) then 1.0 else 0.0))))
      (bind ?den (+ ?den (abs ?c:weight))))
   ; direct pairing suggestions
   (do-for-all-facts ((?s suggest-name)) (eq ?s:name ?name)
      (bind ?num (+ ?num ?s:weight)) (bind ?den (+ ?den (abs ?s:weight))))
   (do-for-all-facts ((?s suggest-style)) (eq ?s:style (beer-style-of ?name))
      (bind ?num (+ ?num ?s:weight)) (bind ?den (+ ?den (abs ?s:weight))))
   ; authoritative CraftBeer food pairing (counted only when the user named foods)
   (if (any-factp ((?k meal-keyword)) TRUE) then
      (bind ?num (+ ?num (* 0.5 (pairing-bonus ?name))))
      (bind ?den (+ ?den 0.5)))
   (if (> ?den 0) then (/ ?num ?den) else 0.0))

;; descending-by-score comparator for (sort): TRUE when ?a must come after ?b
(deffunction beer-score-after (?a ?b) (< (beer-score ?a) (beer-score ?b)))

;; Top-?n beer names ranked by score (descending).
(deffunction beer-rank (?n)
   (bind ?names (create$))
   (do-for-all-facts ((?b beer)) TRUE (bind ?names (create$ ?names ?b:name)))
   (bind ?sorted (sort beer-score-after ?names))
   (bind ?top (create$))
   (loop-for-count (?i 1 (min ?n (length$ ?sorted))) do
      (bind ?top (create$ ?top (nth$ ?i ?sorted))))
   ?top)

;; Pretty-print the top-?n with scores.
(deffunction beer-top (?n)
   (progn$ (?name (beer-rank ?n))
      (printout t (format nil "%6.3f" (beer-score ?name)) "  " ?name crlf)))

;; Short, data-grounded rationale for why beer ?name scored well, from the
;; desires currently in working memory (call before they are retracted).
(deffunction beer-rationale (?name)
   (bind ?txt "")
   (do-for-all-facts ((?d desire)) TRUE
      (bind ?x (beer-axis-value ?name (beer-axis-slot ?d:axis)))
      (if (neq ?x FALSE) then
         (bind ?mu (beer-membership ?d:axis ?d:term ?x))
         (if (> (* ?d:weight ?mu) 0.05) then
            (bind ?txt (str-cat ?txt (if (> (str-length ?txt) 0) then ", " else "")
                                (format nil "%s %s (μ%.2f)" (T (str-cat "" ?d:term)) (T (str-cat "" ?d:axis)) ?mu))))))
   (do-for-all-facts ((?c desire-cat)) (and (> ?c:weight 0) (beer-has-cat ?name ?c:slot ?c:value))
      (bind ?txt (str-cat ?txt (if (> (str-length ?txt) 0) then ", " else "") (T (str-cat "" ?c:value)))))
   (if (any-factp ((?s suggest-name)) (eq ?s:name ?name)) then
      (bind ?txt (str-cat ?txt (if (> (str-length ?txt) 0) then ", " else "") (T "paired with your meal"))))
   (if (any-factp ((?s suggest-style)) (eq ?s:style (beer-style-of ?name))) then
      (bind ?txt (str-cat ?txt (if (> (str-length ?txt) 0) then ", " else "") (T "style suits your meal"))))
   (if (> (pairing-bonus ?name) 0) then
      (bind ?txt (str-cat ?txt (if (> (str-length ?txt) 0) then ", " else "") (T "matches its CraftBeer pairing"))))
   (if (eq ?txt "") then (bind ?txt (T "general match")))
   ?txt)

;;********************
;;* CF -> FUZZY BRIDGE *
;;********************
;; Translate the combined (attribute (name best-X) ...) facts produced by the CF
;; knowledge base into desires/suggestions, rank the beers, and assert
;; (attribute (name beer) (value display) (certainty score)) for the top ?n with
;; score > 0; then drop the temporary desire/suggest facts. The existing CF
;; selection rule (clean-working-memory-and-print-results) formats the result, so
;; the same final UI-state is produced for both backends.
;; Requires the `beer` and `attribute` templates (defined in clips/beerex.clp).
(deffunction beer-generate-fuzzy (?n)
   (do-for-all-facts ((?a attribute)) (eq ?a:name best-color)
      (assert (desire (axis color) (term ?a:value) (weight ?a:certainty))))
   (do-for-all-facts ((?a attribute)) (eq ?a:name best-alcohol)
      (assert (desire (axis alcohol) (term ?a:value) (weight ?a:certainty))))
   (do-for-all-facts ((?a attribute)) (and (eq ?a:name best-flavor) (eq ?a:value hoppy-bitter))
      (assert (desire (axis bitterness) (term high) (weight ?a:certainty))))
   (do-for-all-facts ((?a attribute)) (and (eq ?a:name best-flavor) (neq ?a:value hoppy-bitter))
      (assert (desire-cat (slot flavor) (value ?a:value) (weight ?a:certainty))))
   (do-for-all-facts ((?a attribute)) (eq ?a:name best-carbonation)
      (assert (desire-cat (slot carbonation) (value ?a:value) (weight ?a:certainty))))
   (do-for-all-facts ((?a attribute)) (eq ?a:name best-style)
      (assert (suggest-style (style ?a:value) (weight ?a:certainty))))
   (do-for-all-facts ((?a attribute)) (eq ?a:name best-name)
      (assert (suggest-name (name ?a:value) (weight ?a:certainty))))
   (progn$ (?name (beer-rank ?n))
      (bind ?s (beer-score ?name))
      (if (> ?s 0) then
         (bind ?why (beer-rationale ?name))
         (do-for-fact ((?b beer)) (eq ?b:name ?name)
            (assert (attribute (name beer)
                               (value (format nil "🍺 [%s - %s](%s)%s"
                                              ?b:style ?name ?b:link (serving-info ?name)))
                               (certainty ?s)))
            (assert (beer-why (name ?name) (text ?why))))))
   (do-for-all-facts ((?d desire)) TRUE (retract ?d))
   (do-for-all-facts ((?c desire-cat)) TRUE (retract ?c))
   (do-for-all-facts ((?s suggest-name)) TRUE (retract ?s))
   (do-for-all-facts ((?s suggest-style)) TRUE (retract ?s)))
