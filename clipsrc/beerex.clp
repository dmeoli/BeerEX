
;;;===========================================================================
;;; BeerEX: the Beer EXpert system
;;;
;;;   This expert system suggests a beer to drink according to taste and meal.
;;;
;;;   CLIPS 6.31
;;;
;;;   Author: Donato Meoli
;;;===========================================================================


;;**************
;;* DEFGLOBALS *
;;**************

(defglobal
   ?*high-priority* = 1000
   ?*medium-high-priority* = 100
   ?*medium-low-priority* = -100
   ?*low-priority* = -1000)

;;****************
;;* DEFTEMPLATES *
;;****************

(deftemplate UI-state
   (slot id
      (default-dynamic (gensym*)))
   (slot display)
   (slot help)
   (slot why)
   (slot relation-asserted
      (default none))
   (multislot valid-answers)
   (slot response
      (default none))
   (slot state
      (default middle)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deftemplate attribute
   (slot name)
   (slot value)
   (slot certainty
      (range -1.0 1.0)
      (default 1.0)))

(deftemplate beer
   (slot style
      (type STRING)
      (allowed-strings "Pale Ale" "Dark Lager" "Brown Ale" "India Pale Ale" "Wheat Beer" "Strong Ale"
                       "Belgian Style" "Hybrid Beer" "Porter" "Stout" "Bock" "Scottish-Style Ale"
                       "Wild/Sour" "Pilsener & Pale Lager" "Specialty Beer"))
   (slot name
      (type STRING))
   (multislot alcohol
      (type SYMBOL)
      (allowed-symbols not-detectable mild noticeable harsh))
   (multislot color
      (type SYMBOL)
      (allowed-symbols pale amber brown dark))
   (multislot flavor
      (type SYMBOL)
      (allowed-symbols crisp-clean malty-sweet dark-roasty hoppy-bitter fruity-spicy sour-tart-funky))
   (multislot fermentation
      (type SYMBOL)
      (allowed-symbols top bottom wild))
   (multislot carbonation
      (type SYMBOL)
      (allowed-symbols low medium high))
   (slot link
      (type STRING)))

;;************
;;* DEFFACTS *
;;************

(deffacts startup
   (state-list))

(defrule load-beer-styles-list
   =>
   (load-facts clipsrc/beer-styles.fct))

;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction sort-certainties (?attribute1 ?attribute2)
   (< (fact-slot-value ?attribute1 certainty) (fact-slot-value ?attribute2 certainty)))

(deffunction combine-CFs (?x ?y)
   (if (and (> ?x 0) (> ?y 0))
    then (bind ?c (- (+ ?x ?y) (* ?x ?y)))
    else (if (and (< ?x 0) (< ?y 0))
          then (bind ?c (+ (+ ?x ?y) (* ?x ?y)))
          else (bind ?c (/ (+ ?x ?y ) (- 1 (min (abs ?x) (abs ?y)))))))
   ?c)

(deffunction get-explanation ()
   (bind ?explanation (format nil "%s %n%n" "*... for the following reasons:*"))
   (do-for-all-facts ((?a attribute))
                     (eq ?a:name explanation-scenario)
                     (bind ?explanation (str-cat ?explanation ?a:value " ")))
   (do-for-all-facts ((?a attribute))
                     (eq ?a:name explanation-preference)
                     (bind ?explanation (str-cat ?explanation ?a:value " ")))
   (do-for-all-facts ((?a attribute)) (eq ?a:name explanation-main-meal)
                     (bind ?explanation (str-cat ?explanation ?a:value " ")))
   (do-for-all-facts ((?a attribute)) (eq ?a:name explanation-specific-meal)
                     (bind ?explanation (str-cat ?explanation ?a:value " ")))
   ?explanation)

;;*****************
;;* INITIAL STATE *
;;*****************

(defrule start
   =>
   (set-strategy random)
   (assert (UI-state (display (format nil "%n%s %n%n%s %n%n%s" "Welcome to the Beer EXpert system 🍻️"
                                          (str-cat "⁉️ All I need is that you answer simple questions by choosing "
                                                   "one of the responses that are offered to you.")
                                          "To start, please press the /new button 😄"))
                     (relation-asserted start)
                     (state initial))))

;;***********************
;;* BEER QUESTION RULES *
;;***********************

(defrule load-beer-question-rules
   =>
   (load clipsrc/beer-questions.clp))

;;************************
;;* BEER KNOWLEDGE RULES *
;;************************

(defrule load-beer-knowledge-rules
   =>
   (load clipsrc/beer-knowledge.clp))

;;********************************
;;* BEER SELECTION & PRINT RULES *
;;********************************

(defrule combine-certainties
   ?f1 <- (attribute (name ?name) (value ?value) (certainty ?certainty1))
   ?f2 <- (attribute (name ?name) (value ?value) (certainty ?certainty2))
   (test (neq ?f1 ?f2))
   =>
   (retract ?f1)
   (modify ?f2 (certainty (combine-CFs ?certainty1 ?certainty2))))

(defrule generate-beers
   (declare (salience ?*medium-low-priority*))
   (or (and (beer (style ?beer-style) (name ?beer-name) (link ?link))
            (attribute (name best-style) (value ?beer-style) (certainty ?certainty)))
       (and (beer (style ?beer-style) (name ?beer-name) (link ?link))
            (attribute (name best-name) (value ?beer-name) (certainty ?certainty)))
       (and (beer (style ?beer-style) (name ?beer-name) (alcohol $? ?alcohol $?) (link ?link))
            (attribute (name best-alcohol) (value ?alcohol) (certainty ?certainty)))
       (and (beer (style ?beer-style) (name ?beer-name) (color $? ?color $?) (link ?link))
            (attribute (name best-color) (value ?color) (certainty ?certainty)))
       (and (beer (style ?beer-style) (name ?beer-name) (flavor $? ?flavor $?) (link ?link))
            (attribute (name best-flavor) (value ?flavor) (certainty ?certainty)))
       (and (beer (style ?beer-style) (name ?beer-name) (fermentation $? ?fermentation $?) (link ?link))
            (attribute (name best-fermentation) (value ?fermentation) (certainty ?certainty)))
       (and (beer (style ?beer-style) (name ?beer-name) (carbonation $? ?carbonation $?) (link ?link))
            (attribute (name best-carbonation) (value ?carbonation) (certainty ?certainty))))
   =>
   (assert (attribute (name beer)
                      (value (format nil "🍺 [%s - %s](%s)" ?beer-style ?beer-name ?link))
                      (certainty ?certainty))))

(defrule clean-working-memory-and-print-results
   (declare (salience ?*low-priority*))
   (UI-state (id ?id))
   (state-list (current ?id))
   =>
   (bind ?beers "")
   (bind ?attributes (sort sort-certainties (find-all-facts ((?a attribute)) (eq ?a:name beer))))
   (progn$ (?a ?attributes)
           (if (< (member$ ?a ?attributes) 5)
            then (bind ?beers (str-cat ?beers (format nil "%s with certainty %2d%% %n" (fact-slot-value ?a value)
                                                          (* (fact-slot-value ?a certainty) 100)))))
           (retract ?a))
   (if (neq ?beers "")
    then (bind ?results (str-cat (format nil "%s %n%n%s %n%s" "*✅ Done. I have selected these beer styles for you...*"
                                             ?beers (get-explanation))))
    else (bind ?results (format nil "%s %n%n%s" "*🚫 Sorry! I could not select any beer style for you. 😞"
                                                "Please, try again! 💪🏻*")))
   (do-for-all-facts ((?a attribute)) TRUE (retract ?a))
   (assert (UI-state (display ?results)
                     (state final))))

;;*************************
;;* GUI INTERACTION RULES *
;;*************************

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
