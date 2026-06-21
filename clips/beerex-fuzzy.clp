;;;===========================================================================
;;; beerex-fuzzy.clp - Wires the fuzzy backend into the BeerEX selection stage.
;;;
;;;   Load order matters: AFTER clips/beerex.clp (templates, globals, CF rules)
;;;   and AFTER clips/beer-fuzzy.clp (membership functions, scoring, the
;;;   beer-generate-fuzzy bridge). Keeping this single rule separate lets
;;;   beer-fuzzy.clp stay domain-pure and unit-testable on its own.
;;;
;;;   Author: Donato Meoli
;;;===========================================================================

;; Fires once after the CF evidence has settled (best-* combined) and before the
;; results are printed, only when the fuzzy backend is selected. Mirrors the role
;; of generate-beers (CF): it fills working memory with the same
;; (attribute (name beer) ...) facts that clean-working-memory-and-print-results
;; formats, so the final UI-state is identical in shape for both backends.
(defrule generate-beers-fuzzy
   (declare (salience ?*generate-priority*))
   (UI-state (id ?id))
   (state-list (current ?id))
   (test (eq ?*backend* fuzzy))
   =>
   (beer-generate-fuzzy 5))
