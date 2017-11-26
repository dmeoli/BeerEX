
;;***********************
;;* BEER QUESTION RULES *
;;***********************

; random questions for user type and scenario recognition

(defrule determine-preferred-carbonation
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Do you generally prefer to drink low, medium or high carbonated drinks? 🍾")
                     (relation-asserted preferred-carbonation)
                     (valid-answers low medium high))))

(defrule determine-whether-he-is-a-regular-beer-drinker
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Are you a regular beer drinker? 🍺")
                     (relation-asserted regular-beer-drinker)
                     (valid-answers yes no))))

(defrule determine-preferred-color
   (declare (salience ?*very-high-priority*))
   (regular-beer-drinker yes)
   =>
   (assert (UI-state (display "Do you generally prefer pale, amber, brown or dark beer? 🍺")
                     (relation-asserted preferred-color)
                     (valid-answers pale amber brown dark))))

(defrule determine-preferred-fermentation
   (declare (salience ?*very-high-priority*))
   (regular-beer-drinker yes)
   =>
   (assert (UI-state (display "Do you generally prefer to drink top, bottom or wild fermented beer?")
                     (relation-asserted preferred-fermentation)
                     (valid-answers top bottom wild))))

(defrule determine-whether-he-eats-fermented-foods
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Do you generally eat fermented foods (probiotic yogurt, kefir, kombucha)? 🥛")
                     (relation-asserted fermented-foods-eater)
                     (valid-answers yes no))))

(defrule determine-whether-he-should-drive
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Do you have to drive? 🚘")
                     (relation-asserted driver)
                     (valid-answers yes no))))

(defrule determine-preferred-alcohol
   (declare (salience ?*very-high-priority*))
   (driver no)
   =>
   (assert (UI-state (display "Do you generally prefer to drink low, mild, high or very high alcoholic drinks? 🍹")
                     (relation-asserted preferred-alcohol)
                     (valid-answers low mild high "very high"))))

(defrule determine-whether-he-should-smoke-a-cigar
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Do you have to smoke a cigar? If yes, is the cigar claro, maduro or oscuro? 🚬")
                     (relation-asserted which-cigar)
                     (valid-answers claro maduro oscuro no))))

(defrule determine-preferred-flavor
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "What kind of flavor do you generally prefer?")
                     (relation-asserted preferred-flavor)
                     (valid-answers clean sweet bitter roasty fruity spicy sour "don't know"))))

; depth questions for meal type recognition

(defrule determine-food-style
   (start)
   =>
   (assert (UI-state (display "Are you vegetarian, vegan or omnivorous?")
                     (relation-asserted food-style)
                     (valid-answers vegetarian vegan omnivorous))))

(defrule determine-main-meal-for-omnivorous-or-vegetarian
   (or (food-style omnivorous)
       (food-style vegetarian))
   =>
   (assert (UI-state (display "Is the main meal pizza, entree, cheese or dessert? 🧀")
                     (relation-asserted main-meal-for-omnivorous-or-vegetarian)
                     (valid-answers pizza entree cheese dessert other))))

(defrule determine-main-meal-for-vegan
   (food-style vegan)
   =>
   (assert (UI-state (display "Is the main meal pizza, entree or dessert?")
                     (relation-asserted main-meal-for-vegan)
                     (valid-answers pizza entree dessert other))))

   ; ... if main meal is cheese

(defrule determine-which-cheese-style
   (main-meal-for-omnivorous-or-vegetarian cheese)
   =>
   (assert (UI-state (display (str-cat "Is the cheese style fresh (Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese, "
                                       "Quark, Cottage), semi-soft (Colby, Fontina, Havarti, Monterey Jack), firm/hard "
                                       "(Gouda, Cheddar, Emmental, Gruyère, Parmesan), blue (Roquefort, Gorgonzola), "
                                       "natural-rind (Brie, Camembert, Triple Crème, Mimolette, Stilton, Lancashire) "
                                       "or washed-rind (Epoisses, Livarot, Taleggio)? 🧀"))
                     (relation-asserted which-cheese-style)
                     (valid-answers fresh semi-soft firm/hard blue "natural rind" "washed rind" "don't know"))))

(defrule determine-which-fresh-cheese
   (which-cheese-style fresh)
   =>
   (assert (UI-state (display "Is the fresh cheese Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese or other? 🧀")
                     (relation-asserted which-fresh-cheese)
                     (valid-answers Mascarpone Ricotta Chèvre Feta "Cream Cheese" other))))

(defrule determine-whether-he-should-eat-Mascarpone-with-fruit
   (which-fresh-cheese Mascarpone)
   =>
   (assert (UI-state (display "Do you have to eat Mascarpone with fruit?")
                     (relation-asserted mascarpone-with-fruit)
                     (valid-answers yes no))))

(defrule determine-which-semi-soft-cheese
   (which-cheese-style semi-sof)
   =>
   (assert (UI-state (display "Is the semi-soft cheese Colby, Havarti, Monterey Jack or other? 🧀")
                     (relation-asserted which-semi-soft-cheese)
                     (valid-answers Colby Havarti "Monterey Jack" other))))

(defrule determine-which-firm/hard-cheese
   (which-cheese-style firm/hard)
   =>
   (assert (UI-state (display "Is the firm/hard cheese Gouda, Cheddar, Emmental, Gruyère, Parmesan or other? 🧀")
                     (relation-asserted which-firm/hard-cheese)
                     (valid-answers Gouda Cheddar Emmental Gruyère Parmesan other))))

(defrule determine-which-type-of-Gouda
   (which-firm/hard-cheese Gouda)
   =>
   (assert (UI-state (display "Is the Gouda aged, smoked or other? 🧀")
                     (relation-asserted which-type-of-Gouda)
                     (valid-answers aged smoked other))))

(defrule determine-which-color-of-Cheddar
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (UI-state (display "Is the Cheddar white or yellow? 🧀")
                     (relation-asserted which-color-of-Cheddar)
                     (valid-answers white yellow))))

(defrule determine-which-Cheddar-seasoning
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (UI-state (display "Is the Cheddar seasoning mild, medium, aged or other? 🧀")
                     (relation-asserted which-Cheddar-seasoning)
                     (valid-answers mild medium aged other))))

(defrule determine-if-Cheddar-is-sharp
   (or (which-Cheddar-seasoning medium)
       (which-Cheddar-seasoning aged))
   =>
   (assert (UI-state (display "Is the Cheddar sharp? 🧀")
                     (relation-asserted Cheddar-is-sharp)
                     (valid-answers yes no "don't know"))))

(defrule determine-which-natural-rind-cheese
   (which-cheese-style "natural rind")
   =>
   (assert (UI-state (display (str-cat "Is the natural rind cheese Brie, Camembert, Triple Crème, Mimolette, Stilton, "
                                       "or other? 🧀"))
                     (relation-asserted which-natural-rind-cheese)
                     (valid-answers Brie Camembert "Triple Crème" Mimolette Stilton other))))

(defrule determine-which-washed-rind-cheese
   (which-cheese-style "washed rind")
   =>
   (assert (UI-state (display "Is the washed rind cheese Taleggio or other? 🧀")
                     (relation-asserted which-washed-rind-cheese)
                     (valid-answers Taleggio other))))

   ; ... if main meal is entree

(defrule determine-which-entree-omnivorous
   (food-style omnivorous)
   (main-meal-for-omnivorous-or-vegetarian entree)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entree grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), fish, meat, vegetables, fats "
                                       "or other?"))
                     (relation-asserted which-entree-omnivorous)
                     (valid-answers grain legumes fish meat vegetables fats other))))

(defrule determine-which-entree-vegetarian
   (food-style vegetarian)
   (main-meal-for-omnivorous-or-vegetarian entree)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entree grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), vegetables, vegetables fats "
                                       "(avocados, olive oil, peanut butter, nuts and seeds) or other?"))
                     (relation-asserted which-entree-vegetarian)
                     (valid-answers grain legumes vegetables "vegetables fats" other))))

(defrule determine-which-entree-vegan
   (main-meal-for-vegan entree)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entree grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), vegetables, vegetables fats "
                                       "(avocados, olive oil, peanut butter, nuts and seeds), or other?"))
                     (relation-asserted which-entree-vegan)
                     (valid-answers grain legumes vegetables "vegetables fats" other))))

(defrule determine-which-vegetables
   (or (which-entree-omnivorous vegetables)
       (which-entree-vegetarian vegetables)
       (which-entree-vegan vegetables))
   =>
   (assert (UI-state (display (str-cat "Does the vegetables are root (parsnips, carrots), grilled (peppers, onions, "
                                       "mushrooms) or other?"))
                     (relation-asserted which-vegetables)
                     (valid-answers root grilled other))))

(defrule determine-which-fish
   (which-entree-omnivorous fish)
   =>
   (assert (UI-state (display (str-cat "Does the fish is shellfish (clams, scallops, lobster, crab), bluefish (salmon, "
                                        "trout, tuna) or other? 🦐 🐟"))
                     (relation-asserted which-fish)
                     (valid-answers shellfish bluefish other))))

(defrule determine-which-fats
   (which-entree-omnivorous fats)
   =>
   (assert (UI-state (display (str-cat "Does the fats are vegetable (avocados, olive oil, peanut butter, nuts "
                                       "and seeds) or animal (duck/pork fat, dairy)?"))
                     (relation-asserted which-fats)
                     (valid-answers vegetable animal other))))

(defrule determine-which-meat
   (which-entree-omnivorous meat)
   =>
   (assert (UI-state (display (str-cat "Does the meat is rich meats (beef strip loin, lamb), game birds (duck, quail, "
                                       "quinoa), braised meats (beef short-rib, pork shoulder), pork or other?"))
                     (relation-asserted which-meat)
                     (valid-answers "rich meats" "game birds" "braised meats" pork other))))

(defrule determine-which-pork
   (which-meat pork)
   =>
   (assert (UI-state (display "Does the pork is prosciutto, speck, mortadella, sausage or other?")
                     (relation-asserted which-pork)
                     (valid-answers prosciutto speck mortadella sausage other))))

(defrule determine-which-sausage
   (which-pork sausage)
   =>
   (assert (UI-state (display "Does the sausage is capocollo, soppressata, salame piccante or other?")
                     (relation-asserted which-sausage)
                     (valid-answers capocollo soppressata "salame piccante" other))))

(defrule determine-which-dessert
   (or (which-entree-omnivorous dessert)
       (which-entree-vegetarian dessert))
   =>
   (assert (UI-state (display (str-cat "Does the dessert is creamy (cheesecake, ice cream, creme brûlée, mousse cake), "
                                       "chocolate or other? 🍫"))
                     (relation-asserted which-dessert)
                     (valid-answers creamy chocolate other))))

(defrule determine-which-chocolate
   (which-dessert chocolate)
   =>
   (assert (UI-state (display (str-cat "Does the chocolate is white, milk (35% cacao ca.), semisweet (55% cacao ca.), "
                                       "bittersweet (70% cacao ca.) or unsweetened/bitter (100% cacao)? 🍫"))
                     (relation-asserted which-chocolate)
                     (valid-answers white milk semisweet bittersweet unsweetened/bitter "don't know"))))



;(defrule determine-predominant-dish-taste
;   (start)
;   =>
;   (assert (UI-state (display "Which is the predominant taste of the dish?")
;                     (relation-asserted predominant-dish-taste)
;                     (valid-answers sweet acid spice umami "not tasted yet"))))

;(defrule determine-dish-cooking-method
;   (start)
;   =>
;   (assert (UI-state (display (str-cat "Does the dish cooking method is dry-heat (broiling, grilling, roasting, baking, "
;                                       "sautéing, pan-frying, deep-frying), moist-heat (poaching, simmering, boiling, "
;                                       "steaming) or it is a combination of both (braising, stewing)?"))
;                     (relation-asserted dish-cooking-method)
;                     (valid-answers dry-heat moist-heat combination "don't know"))))
