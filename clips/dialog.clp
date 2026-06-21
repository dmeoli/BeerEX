;;;===========================================================================
;;; dialog.clp - BeerEX dialogue state machine (UI protocol & retraction)
;;;
;;;   The rules that drive the question/answer interaction and let the user go
;;;   back and retract previous answers, keeping working memory consistent.
;;;   Kept separate from the domain logic (clips/beerex.clp) and the selection
;;;   backends so each concern lives in its own file.
;;;
;;;   Load AFTER clips/beerex.clp (it uses its priority globals and the
;;;   UI-state / state-list templates).
;;;
;;;   Author: Donato Meoli
;;;===========================================================================

;; Localize a screen in place before it is shown (only when not in English).
;; English is the source/key; untranslated strings fall back to English.
(defrule translate-ui
   (declare (salience ?*high-priority*))
   ?u <- (UI-state (display ?d) (help ?h) (why ?w) (translated FALSE))
   (test (neq ?*lang* en))
   =>
   (modify ?u (display (T ?d)) (help (T ?h)) (why (T ?w)) (translated TRUE)))

(defrule ask-question
   (declare (salience ?*medium-high-priority*))
   (UI-state (id ?id))
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
   =>
   (modify ?f (current ?id) (sequence ?id ?s))
   (halt))

(defrule handle-next-no-change-none-middle-of-chain
   (declare (salience ?*high-priority*))
   ?f1 <- (next ?id)
   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   =>
   (retract ?f1)
   (modify ?f2 (current ?nid))
   (halt))

(defrule handle-next-response-none-end-of-chain
   (declare (salience ?*high-priority*))
   ?f <- (next ?id)
   (state-list (sequence ?id $?))
   (UI-state (id ?id) (relation-asserted ?relation))
   =>
   (retract ?f)
   (assert (add-response ?id)))

(defrule handle-next-no-change-middle-of-chain
   (declare (salience ?*high-priority*))
   ?f1 <- (next ?id ?response)
   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   (UI-state (id ?id) (response ?response))
   =>
   (retract ?f1)
   (modify ?f2 (current ?nid))
   (halt))

(defrule handle-next-change-middle-of-chain
   (declare (salience ?*high-priority*))
   (next ?id ?response)
   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
   (UI-state (id ?id) (response ~?response))
   ?f2 <- (UI-state (id ?nid))
   =>
   (modify ?f1 (sequence ?b ?id ?e))
   (retract ?f2))

(defrule handle-next-response-end-of-chain
   (declare (salience ?*high-priority*))
   ?f1 <- (next ?id ?response)
   (state-list (sequence ?id $?))
   ?f2 <- (UI-state (id ?id) (response ?expected) (relation-asserted ?relation))
   =>
   (retract ?f1)
   (if (neq ?response ?expected)
    then (modify ?f2 (response ?response)))
   (assert (add-response ?id ?response)))

(defrule handle-add-response
   (declare (salience ?*high-priority*))
   (UI-state (id ?id) (relation-asserted ?relation))
   ?f <- (add-response ?id ?response)
   =>
   (if (eq (str-index " " ?response) FALSE)
    then (str-assert (str-cat "(" ?relation " " ?response ")"))
    else (str-assert (str-cat "(" ?relation " " "\"" ?response "\"" ")")))
   ; record the answer as a possible food keyword for CraftBeer pairing matching
   (assert (meal-keyword (text ?response)))
   (retract ?f))

(defrule handle-add-response-none
   (declare (salience ?*high-priority*))
   (UI-state (id ?id) (relation-asserted ?relation))
   ?f <- (add-response ?id)
   =>
   (str-assert (str-cat "(" ?relation ")"))
   (retract ?f))

(defrule handle-prev
   (declare (salience ?*high-priority*))
   ?f1 <- (prev ?id)
   (UI-state (id ?id) (state ?state))
   ?f2 <- (state-list (sequence $?b ?id ?pid $?e))
   (UI-state (id ?pid) (relation-asserted ?relation))
   =>
   (retract ?f1)
   (modify ?f2 (current ?pid))
   (do-for-fact ((?r ?relation)) (neq ?relation start) (retract ?r))
   (if (eq (get-strategy) random)
    then (progn$ (?rule (get-defrule-list))
                 (if (neq (str-index "random-question" ?rule) FALSE)
                  then (refresh ?rule))))
   (if (eq ?state final)
    then (progn$ (?rule (get-defrule-list))
                 (if (neq (str-index "determine-best-beer-attributes" ?rule) FALSE)
                  then (refresh ?rule))))
   (halt))
