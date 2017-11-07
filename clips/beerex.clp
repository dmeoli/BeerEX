
;;;==========================================================
;;; BeerEX: the Beer EXpert system
;;;
;;;   This expert system suggests a beer to drink with a meal.
;;;
;;;   For use with BeerEX.bot.py
;;;
;;;   CLIPS Version 6.30
;;;
;;;   Author: Donato Meoli
;;;===========================================================


;;; ****************
;;; * DEFTEMPLATES *
;;; ****************

(deftemplate UI-state
   (slot id
      (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted
      (default none))
   (slot response
      (default none))
   (multislot valid-answers)
   (slot state
      (default middle)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deftemplate attribute
   (slot name)
   (slot value)
   (slot certainty
      (default 100.0)))

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

;;*****************
;;* INITIAL STATE *
;;*****************

(deffacts startup
   (state-list))

(defrule load-files-and-print-welcome-message
  =>
  (load-facts "./clips/beer-styles.clp")
  (load "./clips/beer-questions.clp")
  (load "./clips/beer-knowledge.clp")
  (load "./clips/gui-interaction.clp")
  (assert (UI-state (display (format nil "%n%s %n%n%s %n%n%s" "Welcome to the Beer EXpert system 🍻️"
                                         (str-cat "⁉️ All I need is that you answer simple questions by choosing "
                                                  "one of the responses that are offered to you.")
                                         "To start, please press the /new button 😄"))
                    (relation-asserted start)
                    (state initial))))

;;********************************
;;* BEER SELECTION & PRINT RULES *
;;********************************

(defrule combine-certainties
   (declare (salience 10))
   ?fact1 <- (attribute (name ?name) (value ?value) (certainty ?certainty1))
   ?fact2 <- (attribute (name ?name) (value ?value) (certainty ?certainty2))
   (test (neq ?fact1 ?fact2))
   =>
   (retract ?fact1)
   (modify ?fact2 (certainty (/ (- (* 100 (+ ?certainty1 ?certainty2)) (* ?certainty1 ?certainty2)) 100))))

(defrule select-beers
   (declare (salience -5))
   (or (and (beer (name ?beer-name))
            (attribute (name best-name) (value ?beer-name) (certainty ?certainty)))
       (and (beer (name ?beer-name) (style ?beer-style))
            (attribute (name best-style) (value ?beer-style) (certainty ?certainty)))
       (and (beer (name ?beer-name) (alcohol $? ?alcohol $?))
            (attribute (name best-alcohol) (value ?alcohol) (certainty ?certainty)))
       (and (beer (name ?beer-name) (color $? ?color $?))
            (attribute (name best-color) (value ?color) (certainty ?certainty)))
       (and (beer (name ?beer-name) (flavor $? ?flavor $?))
            (attribute (name best-flavor) (value ?flavor) (certainty ?certainty)))
       (and (beer (name ?beer-name) (fermentation $? ?fermentation $?))
            (attribute (name best-fermentation) (value ?fermentation) (certainty ?certainty)))
       (and (beer (name ?beer-name) (carbonation $? ?carbonation $?))
            (attribute (name best-carbonation) (value ?carbonation) (certainty ?certainty))))
   =>
   (assert (attribute (name beer) (value ?beer-name) (certainty ?certainty))))

(defrule print-beers
   (declare (salience -10))
   (UI-state (id ?id))
   (state-list (current ?id))
   =>
   (bind ?results (format nil "%s %n%n" "*✅ Done. I have selected these beer styles for you.*"))
   (do-for-all-facts ((?a attribute) (?b beer))
                     (and (eq ?a:name beer)
                          (eq ?a:value ?b:name)
                          (not (any-factp ((?a1 attribute)) (and (eq ?a1:name beer)
                                                                 (> ?a1:certainty ?a:certainty)))))
                     (and (retract ?a)
                          (bind ?results (str-cat ?results (format nil "🍺 [%s - %s](%s) with certainty %-2d%% %n"
                                                                        ?b:style ?b:name ?b:link ?a:certainty)))))
   (assert (UI-state (display ?results)
                     (state final))))

(defrule remove-poor-beer-choices
   ?fact <- (attribute (name beer) (certainty ?certainty&:(< ?certainty 49)))
   =>
   (retract ?fact))