
;;***********************
;;* BEER QUESTION RULES *
;;***********************

; random questions for user type recognition

(defrule determine-food-intolerance
   (start)
   =>
   (assert (UI-state (display "Are you intolerant to gluten or yeast?")
                     (relation-asserted food-intolerance)
                     (valid-answers gluten yeast no)))
   (set-strategy random))

(defrule determine-food-style
   (declare (salience ?*very-high-priority*))
   (or (food-intolerance no)
       (food-intolerance yeast))
   =>
   (assert (UI-state (display "Are you vegetarian, vegan or omnivorous?")
                     (relation-asserted food-style)
                     (valid-answers vegetarian vegan omnivorous))))

(defrule determine-which-chocolate-for-omnivorous-or-vegetarian-yeast-intolerant
   (declare (salience ?*very-high-priority*))
   (food-intolerance yeast)
   (or (food-style omnivorous)
       (food-style vegetarian))
   =>
   (assert (UI-state (display "Do you have to eat bittersweet (70% cacao ca.) or unsweetened/bitter (100% cacao)? 🍫")
                     (relation-asserted chocolate-for-omnivorous-or-vegetarian-yeast-intolerant)
                     (valid-answers bittersweet unsweetened/bitter no))))

(defrule determine-if-chocolate-for-vegan-yeast-intolerant-is-unsweetened/bitter
   (declare (salience ?*very-high-priority*))
   (food-intolerance yeast)
   (food-style vegan)
   =>
   (assert (UI-state (display "Do you have to eat unsweetened/bitter (100% cacao) chocolate? 🍫")
                     (relation-asserted chocolate-for-vegan-yeast-intolerant-is-unsweetened/bitter)
                     (valid-answers yes no))))

(defrule determine-whether-he-is-a-driver
   (declare (salience ?*very-high-priority*))
   (food-intolerance no)
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
                     (valid-answers low mild high "very high" "don't mind"))))

(defrule determine-preferred-color
   (declare (salience ?*very-high-priority*))
   (food-intolerance no)
   =>
   (assert (UI-state (display "Do you generally prefer pale, amber, brown or dark beer? 🍺")
                     (relation-asserted preferred-color)
                     (valid-answers pale amber brown dark "don't mind"))))

(defrule determine-preferred-carbonation
   (declare (salience ?*very-high-priority*))
   (food-intolerance no)
   =>
   (assert (UI-state (display "Do you generally prefer to drink low, medium or high carbonated drinks? 🍾")
                     (relation-asserted preferred-carbonation)
                     (valid-answers low medium high "don't mind"))))

(defrule determine-whether-he-is-a-smoker
   (declare (salience ?*very-high-priority*))
   (food-intolerance no)
   =>
   (assert (UI-state (display "Do you smoke cigarettes? 🚬")
                     (relation-asserted smoker)
                     (valid-answers yes no))))

(defrule determine-whether-he-eats-fermented-foods
   (declare (salience ?*very-high-priority*))
   (food-intolerance no)
   =>
   (assert (UI-state (display "Do you generally eat fermented foods (probiotic yogurt, kefir, kombucha)? 🥛")
                     (relation-asserted fermented-foods-eater)
                     (valid-answers yes no))))

; random questions for user type recognition which switch strategy into depth

(defrule determine-whether-it-enjoy-drink-wine
   (declare (salience ?*high-priority*))
   (food-intolerance no)
   =>
   (assert (UI-state (display "Do you also enjoy drink wine? 🍷")
                     (relation-asserted drink-wine)
                     (valid-answers yes no)))
   (set-strategy depth))

(defrule determine-preferred-wine
   (declare (salience ?*high-priority*))
   (drink-wine yes)
   =>
   (assert (UI-state (display "What type of wine do you generally prefer to drink? 🍷")
                     (relation-asserted preferred-wine)
                     (valid-answers Chardonnay "Pinot Noir" "Pinot Gris" "Sauvignon Blanc" "Cabernet Sauvignon" Merlot
                                    Malbec Zinfandels Syrah Chianti Port "don't know"))))

(defrule determine-preferred-flavor
   (declare (salience ?*high-priority*))
   (food-intolerance no)
   =>
   (assert (UI-state (display "What kind of flavor do you generally prefer?")
                     (relation-asserted preferred-flavor)
                     (valid-answers clean sweet bitter roasty fruity spicy sour "don't mind")))
   (set-strategy depth))

(defrule determine-preferred-aroma-for-sweet-flavor
   (declare (salience ?*high-priority*))
   (preferred-flavor sweet)
   =>
   (assert (UI-state (display "What kind of sweet aroma do you generally prefer?")
                     (relation-asserted preferred-aroma-for-sweet-flavor)
                     (valid-answers toasty caramelly "don't mind"))))

(defrule determine-preferred-aroma-for-bitter-flavor
   (declare (salience ?*high-priority*))
   (preferred-flavor bitter)
   =>
   (assert (UI-state (display (str-cat "Do you generally prefer an earthy (herbal deep bittering notes), malt-forward "
                                       "(caramel) or strong-hop (citrus, resin, tropical fruit) aroma for bitter flavor?"))
                     (relation-asserted preferred-aroma-for-bitter-flavor)
                     (valid-answers earthy malt-forward strong-hop "don't mind"))))

(defrule determine-preferred-aroma-for-roasty-flavor
   (declare (salience ?*high-priority*))
   (preferred-flavor roasty)
   =>
   (assert (UI-state (display (str-cat "Do you generally prefer a malty (milk chocolate, raw tree nuts, coffee with "
                                        "cream) or dry (burnt grain, dark chocolate, espresso) aroma for roasty flavor?"))
                     (relation-asserted preferred-aroma-for-roasty-flavor)
                     (valid-answers malty dry "don't mind"))))

(defrule determine-preferred-aroma-for-fruity-flavor
   (declare (salience ?*high-priority*))
   (preferred-flavor fruity)
   =>
   (assert (UI-state (display (str-cat "Do you generally prefer brighter (apple, pear, peach, orange, lemon, apricot) "
                                       "or darker (fig, raspberry, prune, raisin, cherry, plum, strawberry) fruit "
                                       "aroma for fruity flavor?"))
                     (relation-asserted preferred-aroma-for-fruity-flavor)
                     (valid-answers brighter darker "don't mind"))))

(defrule determine-preferred-aroma-for-spicy-flavor
   (declare (salience ?*high-priority*))
   (preferred-flavor spicy)
   =>
   (assert (UI-state (display (str-cat "Do you generally prefer brighter (vanilla, coriander, bay leaf) or darker "
                                       "(clove, pepper, nutmeg) spice aroma for spicy flavor?"))
                     (relation-asserted preferred-aroma-for-spicy-flavor)
                     (valid-answers brighter darker "don't mind"))))

(defrule determine-preferred-aroma-for-sour-flavor
   (declare (salience ?*high-priority*))
   (preferred-flavor sour)
   =>
   (assert (UI-state (display "Do you generally prefer light, medium or strong aroma for sour flavor?")
                     (relation-asserted preferred-aroma-for-sour-flavor)
                     (valid-answers light medium strong "don't mind"))))

; depth questions for meal type recognition

(defrule determine-main-meal-omnivorous
   (food-intolerance no)
   (food-style omnivorous)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the meal grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), fish, meat, vegetables, fats, "
                                       "cheese, dessert or other? 🧀"))
                     (relation-asserted main-meal-omnivorous)
                     (valid-answers grain legumes fish meat vegetables fats cheese dessert other))))

(defrule determine-main-meal-vegetarian
   (food-intolerance no)
   (food-style vegetarian)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the meal grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), vegetables, vegetables fats "
                                       "(avocados, olive oil, peanut butter, nuts and seeds), cheese, dessert "
                                       "or other? 🧀"))
                     (relation-asserted main-meal-vegetarian)
                     (valid-answers grain legumes vegetables "vegetables fats" cheese dessert other))))

(defrule determine-main-meal-vegan
   (food-intolerance no)
   (food-style vegan)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the meal grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), vegetables, vegetables fats "
                                       "(avocados, olive oil, peanut butter, nuts and seeds), "
                                       "unsweetened/bitter (100% cacao) chocolate or other? 🍫"))
                     (relation-asserted main-meal-vegan)
                     (valid-answers grain legumes vegetables "vegetables fats" "unsweetened/bitter chocolate" other))))

(defrule determine-which-vegetables
   (or (main-meal-omnivorous vegetables)
       (main-meal-vegetarian vegetables)
       (main-meal-vegan vegetables))
   =>
   (assert (UI-state (display (str-cat "Does the vegetables are root (parsnips, carrots), grilled (peppers, onions, "
                                       "mushrooms) or other?"))
                     (relation-asserted which-vegetables)
                     (valid-answers root grilled other))))

(defrule determine-which-fish
   (main-meal-omnivorous fish)
   =>
   (assert (UI-state (display (str-cat "Does the fish is shellfish (clams, scallops, lobster, crab), bluefish (salmon, "
                                        "trout, tuna) or other? 🦐 🐟"))
                     (relation-asserted which-fish)
                     (valid-answers shellfish bluefish other))))

(defrule determine-which-fats
   (main-meal-omnivorous fats)
   =>
   (assert (UI-state (display (str-cat "Does the fats are vegetable (avocados, olive oil, peanut butter, nuts "
                                       "and seeds) or animal (duck/pork fat, dairy)?"))
                     (relation-asserted which-fats)
                     (valid-answers vegetable animal other))))

(defrule determine-which-meat
   (main-meal-omnivorous meat)
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

(defrule determine-which-cheese-style
   (or (main-meal-omnivorous cheese)
       (main-meal-vegetarian cheese))
   =>
   (assert (UI-state (display (str-cat "Does the cheese style is fresh (Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese, "
                                       "Quark, Cottage), soft-ripened (Brie, Camembert, Triple Crème), semi-soft "
                                       "(Colby, Fontina, Havarti, Monterey Jack), firm/hard (Gouda, Cheddar, "
                                       "Emmenthaler, Gruyère, Parmesan), blue (Roquefort, Gorgonzola), natural-rind "
                                       "(Mimolette, Stilton, Lancashire) or washed-rind (Epoisses, Livarot, Taleggio)? 🧀"))
                     (relation-asserted which-cheese-style)
                     (valid-answers fresh soft-ripened semi-soft firm/hard blue "natural rind" "washed rind" "don't know"))))

(defrule determine-which-dessert
   (or (main-meal-omnivorous dessert)
       (main-meal-vegetarian dessert))
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
;   (food-intolerance no)
;   =>
;   (assert (UI-state (display "Which is the predominant taste of the dish?")
;                     (relation-asserted predominant-dish-taste)
;                     (valid-answers sweet acid spice umami "not tasted yet"))))

;(defrule determine-dish-cooking-method
;   (food-intolerance no)
;   =>
;   (assert (UI-state (display (str-cat "Does the dish cooking method is dry-heat (broiling, grilling, roasting, baking, "
;                                       "sautéing, pan-frying, deep-frying), moist-heat (poaching, simmering, boiling, "
;                                       "steaming) or it is a combination of both (braising, stewing)?"))
;                     (relation-asserted dish-cooking-method)
;                     (valid-answers dry-heat moist-heat combination "don't know"))))
