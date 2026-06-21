
;;**************
;;* DEFGLOBALS *
;;**************

(defglobal
   ?*high-priority* = 1000
   ?*medium-high-priority* = 100
   ?*medium-low-priority* = -100
   ?*generate-priority* = -500
   ?*low-priority* = -1000
   ?*backend* = fuzzy   ; selection backend: cf | fuzzy
   ?*lang* = en)        ; output language: en (base) | it (optional overlay)

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
      (default middle))
   (slot translated
      (default FALSE)))

;; Optional localization (gettext-style): English is the source/key, the IT (or
;; other) text is an overlay with English fallback. See clips/labels-it.clp.
(deftemplate translation
   (slot en (type STRING))
   (slot it (type STRING)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deftemplate attribute
   (slot name)
   (slot value)
   (slot certainty
      (range -1.0 1.0)
      (default 1.0)))

;; Per-beer rationale produced by the fuzzy backend (which factors matched and
;; how strongly), used to build a data-grounded explanation.
(deftemplate beer-why
   (slot name)
   (slot text))

;; A food the user mentioned during the dialogue (asserted from each answer),
;; matched against the authoritative CraftBeer pairings (see clips/beer-data.clp).
(deftemplate meal-keyword
   (slot text))

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
   (load-facts clips/beer-styles.fct))

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

;; Localize a string: in non-English mode return its translation (English
;; fallback if none); nil/empty pass through unchanged. English is the source key.
(deffunction T (?s)
   (if (eq ?*lang* en) then (return ?s))
   (do-for-fact ((?t translation)) (eq ?t:en ?s) (return ?t:it))
   ?s)

(deffunction get-explanation ()
   (bind ?explanation (format nil "%s %n%n" (T "*... for the following reasons:*")))
   (do-for-all-facts ((?a attribute))
                     (eq ?a:name explanation-scenario)
                     (bind ?explanation (str-cat ?explanation (T ?a:value) " ")))
   (do-for-all-facts ((?a attribute))
                     (eq ?a:name explanation-preference)
                     (bind ?explanation (str-cat ?explanation (T ?a:value) " ")))
   (do-for-all-facts ((?a attribute)) (eq ?a:name explanation-main-meal)
                     (bind ?explanation (str-cat ?explanation (T ?a:value) " ")))
   (do-for-all-facts ((?a attribute)) (eq ?a:name explanation-specific-meal)
                     (bind ?explanation (str-cat ?explanation (T ?a:value) " ")))
   ; fuzzy backend: append a data-grounded, per-beer rationale
   (if (any-factp ((?w beer-why)) TRUE) then
      (bind ?explanation (str-cat ?explanation (format nil "%n%n%s%n" (T "*🔎 Why these beers:*"))))
      (do-for-all-facts ((?w beer-why)) TRUE
         (bind ?explanation (str-cat ?explanation (format nil "• *%s* — %s%n" ?w:name ?w:text)))))
   ?explanation)

;;*****************
;;* INITIAL STATE *
;;*****************

(defrule start
   =>
   (set-strategy random)
   (assert (UI-state (display (format nil "%n%s %n%n%s %n%n%s" (T "Welcome to the Beer EXpert system 🍻️")
                                          (T (str-cat "⁉️ All I need is that you answer simple questions by choosing "
                                                      "one of the responses that are offered to you."))
                                          (T "To start, please press the /new button 😄")))
                     (relation-asserted start)
                     (state initial))))

;;***********************
;;* BEER QUESTION RULES *
;;***********************

(defrule load-beer-question-rules
   =>
   (load clips/beer-questions.clp))

;;************************
;;* BEER KNOWLEDGE RULES *
;;************************

(defrule load-beer-knowledge-rules
   =>
   (load clips/beer-knowledge.clp))

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
   (test (eq ?*backend* cf))
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
            then (bind ?beers (str-cat ?beers (format nil "%s %s %2d%% %n" (fact-slot-value ?a value)
                                                          (T "with certainty") (* (fact-slot-value ?a certainty) 100)))))
           (retract ?a))
   (if (neq ?beers "")
    then (bind ?results (str-cat (format nil "%s %n%n%s %n%s" (T "*✅ Done. I have selected these beer styles for you...*")
                                             ?beers (get-explanation))))
    else (bind ?results (format nil "%s %n%n%s" (T "*🚫 Sorry! I could not select any beer style for you. 😞")
                                                (T "Please, try again! 💪🏻*"))))
   (do-for-all-facts ((?a attribute)) TRUE (retract ?a))
   (do-for-all-facts ((?w beer-why)) TRUE (retract ?w))
   (assert (UI-state (display ?results)
                     (state final))))
