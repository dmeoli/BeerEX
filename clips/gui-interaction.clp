
(defrule ask-question
   (declare (salience 5))
   (UI-state (id ?id))
   ?fact <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
   =>
   (modify ?fact (current ?id) (sequence ?id ?s))
   (halt))

(defrule handle-next-no-change-none-middle-of-chain
   (declare (salience 10))
   ?fact1 <- (next ?id)
   ?fact2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
   =>
   (retract ?fact1)
   (modify ?fact2 (current ?nid))
   (halt))

(defrule handle-next-response-none-end-of-chain
   (declare (salience 10))
   ?fact <- (next ?id)
   (state-list (sequence ?id $?))
   (UI-state (id ?id) (relation-asserted ?relation))
   =>
   (retract ?fact)
   (assert (add-response ?id)))

(defrule handle-add-response
   (declare (salience 10))
   (UI-state (id ?id) (relation-asserted ?relation))
   ?fact <- (add-response ?id ?response)
   =>
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   (retract ?fact))

(defrule handle-add-response-none
   (declare (salience 10))
   (UI-state (id ?id) (relation-asserted ?relation))
   ?fact <- (add-response ?id)
   =>
   (str-assert (str-cat "(" ?relation ")"))
   (retract ?fact))

(defrule handle-prev
   (declare (salience 10))
   ?fact1 <- (prev ?id)
   ?fact2 <- (state-list (sequence $?b ?id ?p $?e))
   (UI-state (id ?p) (relation-asserted ?relation))
   =>
   (retract ?fact1)
   (find-fact ((?f ?relation)) (retract ?f))
   (modify ?fact2 (current ?p))
   (halt))