
(defrule ask-question
   (declare (salience ?*medium-high-priority*))
   (UI-state (id ?id))
   ?fact <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
   =>
   (modify ?fact (current ?id) (sequence ?id ?s))
   (halt))

(defrule handle-next-no-change-none-middle-of-chain
   (declare (salience ?*high-priority*))
   ?fact1 <- (next ?id)
   ?fact2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   =>
   (retract ?fact1)
   (modify ?fact2 (current ?nid))
   (halt))

(defrule handle-next-response-none-end-of-chain
   (declare (salience ?*high-priority*))
   ?fact <- (next ?id)
   (state-list (sequence ?id $?))
   (UI-state (id ?id) (relation-asserted ?relation))
   =>
   (retract ?fact)
   (assert (add-response ?id)))

(defrule handle-next-no-change-middle-of-chain
   (declare (salience ?*high-priority*))
   ?fact1 <- (next ?id ?response)
   ?fact2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   (UI-state (id ?id) (response ?response))
   =>
   (retract ?fact1)
   (modify ?fact2 (current ?nid))
   (halt))

(defrule handle-next-change-middle-of-chain
   (declare (salience ?*high-priority*))
   (next ?id ?response)
   ?fact1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
   (UI-state (id ?id) (response ~?response))
   ?fact2 <- (UI-state (id ?nid))
   =>
   (modify ?fact1 (sequence ?b ?id ?e))
   (retract ?fact2))

(defrule handle-next-response-end-of-chain
   (declare (salience ?*high-priority*))
   ?fact1 <- (next ?id ?response)
   (state-list (sequence ?id $?))
   ?fact2 <- (UI-state (id ?id) (response ?expected) (relation-asserted ?relation))
   =>
   (retract ?fact1)
   (if (neq ?response ?expected)
    then (modify ?fact2 (response ?response)))
   (assert (add-response ?id ?response)))

(defrule handle-add-response
   (declare (salience ?*high-priority*))
   (UI-state (id ?id) (relation-asserted ?relation))
   ?fact <- (add-response ?id ?response)
   =>
   (if (eq (str-index " " ?response) FALSE)
    then (str-assert (str-cat "(" ?relation " " ?response ")"))
    else (str-assert (str-cat "(" ?relation " " "\"" ?response "\"" ")")))
   (retract ?fact))

(defrule handle-add-response-none
   (declare (salience ?*high-priority*))
   (UI-state (id ?id) (relation-asserted ?relation))
   ?fact <- (add-response ?id)
   =>
   (str-assert (str-cat "(" ?relation ")"))
   (retract ?fact))

(defrule handle-prev
   (declare (salience ?*high-priority*))
   ?fact1 <- (prev ?id)
   ?fact2 <- (UI-state (id ?id))
   ?fact3 <- (UI-state (id ?pid) (relation-asserted ?relation))
   ?fact4 <- (state-list (current ?id) (sequence ?id ?pid $?e))
   =>
   (retract ?fact1)
   (retract ?fact2)
   (modify ?fact3 (response none))
   (modify ?fact4 (current ?pid) (sequence ?pid ?e))
   (do-for-fact ((?f ?relation)) (neq ?relation start) (retract ?f))
   (halt))
