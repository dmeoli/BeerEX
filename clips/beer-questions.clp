
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
   (assert (UI-state (display "Is the main meal pizza, entrée, cheese or dessert? 🧀")
                     (relation-asserted main-meal-for-omnivorous-or-vegetarian)
                     (valid-answers pizza entrée cheese dessert other))))

(defrule determine-main-meal-for-vegan
   (food-style vegan)
   =>
   (assert (UI-state (display "Is the main meal pizza, entrée or dessert?")
                     (relation-asserted main-meal-for-vegan)
                     (valid-answers pizza entrée dessert other))))

   ; ... if main meal is cheese

(defrule determine-which-cheese-style
   (main-meal-for-omnivorous-or-vegetarian cheese)
   =>
   (assert (UI-state (display (str-cat "Is the cheese style fresh (Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese, "
                                       "Quark, Cottage), semi-soft (Colby, Fontina, Havarti, Monterey Jack), firm/hard "
                                       "(Gouda, Cheddar, Swiss, Parmesan), blue (Roquefort, Gorgonzola, Danish), "
                                       "natural rind (Brie, Camembert, Triple Crème, Mimolette, Stilton, Lancashire, "
                                       "Tomme de Savoie) or washed rind (Epoisses, Livarot, Taleggio)? 🧀"))
                     (help (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                       (str-cat "🧀 Fresh cheeses have not been aged, or are very slightly cured. These "
                                                "cheeses have a high moisture content and are usually mild and have a "
                                                "very creamy taste and soft texture.")
                                       (str-cat "🧀 [Semi-soft](goo.gl/izu1Bw) cheeses have a smooth, generally, creamy "
                                                "interior with little or no rind. These cheeses are generally high in "
                                                "moisture content and range from very mild in flavor to very pungent.")
                                       (str-cat "🧀 [Firm/hard](goo.gl/yrfoJK) cheeses have a taste profiles range from "
                                                "very mild to sharp and pungent. They generally have a texture profile "
                                                "that ranges from elastic, at room temperature, to the hard cheeses that "
                                                "can be grated.")
                                       (str-cat "🧀 [Blue](goo.gl/9KkNww) cheeses have a distinctive blue/green veining, "
                                                "created when the penicillium roqueforti mold, added during the make "
                                                "process, is exposed to air. This mold provides a distinct flavor to the "
                                                "cheese, which ranges from fairly mild to assertive and pungent.")
                                       (str-cat "🧀 [Natural rind](goo.gl/ys8pkz) cheeses have rinds that are "
                                                "self-formed during the aging process. Generally, no molds or microflora "
                                                "are added, nor is washing used to create the exterior rinds, and those "
                                                "that do exhibit molds and microflora in their rinds get them naturally "
                                                "from the environment.")
                                       (str-cat "🧀 [Washed rind](goo.gl/Kh3BwD) is used to describe those cheeses that "
                                                "are surface-ripened by washing the cheese throughout the ripening/aging "
                                                "process with brine, beer, wine, brandy, or a mixture of ingredients, "
                                                "which encourages the growth of bacteria. The exterior rind of washed "
                                                "rind cheeses may vary from bright orange to brown, with flavor and "
                                                "aroma profiles that are quite pungent, yet the interior of these "
                                                "cheeses is most often semi-soft and, sometimes, very creamy.")))
                     (why (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                      (str-cat "🧀 Fresh cheeses are light cheeses which pair excellently with the "
                                               "softer flavors of Wheat and Lambic beers.")
                                      (str-cat "🧀 The vast variety of [semi-soft](goo.gl/izu1Bw) can be paired with "
                                               "many different craft beers, such as German Kölsch or Bock and Pale Ale "
                                               "beers.")
                                      (str-cat "🧀 Because of their variety, [firm/hard](goo.gl/yrfoJK) are easily "
                                               "paried with an equally broad range of craft beer styles, such as "
                                               "Pilsner, Bock, Brown Ale and Imperial Stout.")
                                      (str-cat "🧀 [Blue](goo.gl/9KkNww) are stronger-flavored cheeses which are most "
                                               "successfully balanced with stonger-flavored bolder beers like IPAs or "
                                               "Imperial IPAs.")
                                      (str-cat "🧀 [Natural rind](goo.gl/ys8pkz) cheeses include Tomme de Savoie styles "
                                               "which pair well with Golden Ales or Blondes. Traditional British-style "
                                               "ales work well with English-style natural rind cheeses, such as "
                                               "Lancashire and Stilton.")
                                      (str-cat "🧀 [Washed rind](goo.gl/Kh3BwD) itself, while potentially pungent, is "
                                               "often creamy. Pair Belgian-styles ales, like Triples and Golden Strong "
                                               "ales with these varieties.")))
                     (relation-asserted which-cheese-style)
                     (valid-answers fresh semi-soft firm/hard blue "natural rind" "washed rind" "don't know"))))

(defrule determine-which-fresh-cheese
   (which-cheese-style fresh)
   =>
   (assert (UI-state (display "Is the fresh cheese Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese or other? 🧀")
                     (why (str-cat "🧀 Italian-Style Mascarpone, Ricotta and soft Chèvre will match the delicate notes "
                                   "of the beer and neither will overwhelm the palate in the beginning of a meal."))
                     (relation-asserted which-fresh-cheese)
                     (valid-answers Mascarpone Ricotta Chèvre Feta "Cream Cheese" other))))

(defrule determine-whether-he-should-eat-Mascarpone-with-fruit
   (which-fresh-cheese Mascarpone)
   =>
   (assert (UI-state (display "Do you have to eat Mascarpone with fruit?")
                     (relation-asserted mascarpone-with-fruit)
                     (valid-answers yes no))))

(defrule determine-which-semi-soft-cheese
   (which-cheese-style semi-soft)
   =>
   (assert (UI-state (display "Is the semi-soft cheese Colby, Havarti, Monterey Jack or other? 🧀")
                     (why (str-cat "🧀 Fontina, Havarti and milder blue cheeses can be enhanced by the carbonation of "
                                   "Kölsch style ales. The gentle notes of grass in the cheese can be brought out by "
                                   "using the malt of a Bock or the hops of a Pale Ale."))
                     (relation-asserted which-semi-soft-cheese)
                     (valid-answers Colby Havarti "Monterey Jack" other))))

(defrule determine-which-firm/hard-cheese
   (which-cheese-style firm/hard)
   =>
   (assert (UI-state (display "Is the firm/hard cheese Gouda, Cheddar, Swiss, Parmesan or other? 🧀")
                     (why (str-cat "🧀 Cheddar and Swiss cheeses can mimic the Maillard reaction when paired with a beer "
                                   "style, such as a Brown Ale. Roasty stouts can add a creaminess to the firm and hard "
                                   "cheeses on the palate."))
                     (relation-asserted which-firm/hard-cheese)
                     (valid-answers Gouda Cheddar Swiss Parmesan other))))

(defrule determine-which-type-of-Gouda
   (which-firm/hard-cheese Gouda)
   =>
   (assert (UI-state (display "Is the Gouda cheese aged, smoked or other? 🧀")
                     (relation-asserted which-type-of-Gouda)
                     (valid-answers aged smoked other))))

(defrule determine-which-color-of-Cheddar
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (UI-state (display "Is the Cheddar cheese white or yellow? 🧀")
                     (relation-asserted which-color-of-Cheddar)
                     (valid-answers white yellow))))

(defrule determine-which-Cheddar-seasoning
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (UI-state (display "Is the Cheddar cheese seasoning mild, medium, aged or other? 🧀")
                     (relation-asserted which-Cheddar-seasoning)
                     (valid-answers mild medium aged other))))

(defrule determine-if-Cheddar-is-sharp
   (or (which-Cheddar-seasoning medium)
       (which-Cheddar-seasoning aged))
   =>
   (assert (UI-state (display "Is the Cheddar cheese sharp? 🧀")
                     (relation-asserted Cheddar-is-sharp)
                     (valid-answers yes no "don't know"))))

(defrule determine-which-type-of-Swiss
   (which-firm/hard-cheese Swiss)
   =>
   (assert (UI-state (display "Is the Swiss cheese Emmental, Gruyère or other? 🧀")
                     (why (str-cat "🧀 Emmentaler-style cheeses can mimic the Maillard reaction when paired with a beer "
                                   "style, such as a Brown Ale."))
                     (relation-asserted which-type-of-Swiss)
                     (valid-answers Emmental Gruyère other))))

(defrule determine-which-blue-cheese
   (which-cheese-style blue)
   =>
   (assert (UI-state (display (str-cat "Is the blue cheese Stilton or other? 🧀"))
                     (why "🧀 Stilton cheese can be intensified the sweetness on the palate with a Barley Wine.")
                     (relation-asserted which-blue-cheese)
                     (valid-answers Stilton other))))

(defrule determine-which-natural-rind-cheese
   (which-cheese-style "natural rind")
   =>
   (assert (UI-state (display (str-cat "Is the natural rind cheese Brie, Camembert, Triple Crème, Mimolette, Stilton, "
                                       "or other? 🧀"))
                     (why (str-cat "🧀 Lancashire, Stilton, Brie and Camembert all share a rich creamy base that can be "
                                   "refreshed with a Golden, Blond or Pale Ale or intensified the sweetness on the "
                                   "palate with a Barley Wine."))
                     (relation-asserted which-natural-rind-cheese)
                     (valid-answers Brie Camembert "Triple Crème" Mimolette Stilton other))))

(defrule determine-which-washed-rind-cheese
   (which-cheese-style "washed rind")
   =>
   (assert (UI-state (display "Is the washed rind cheese Taleggio or other? 🧀")
                     (why (str-cat "🧀 Classic Belgian yeast flavors spur a tighter carbonation as well as bring out "
                                   "delicate sweet notes that can cut through the funk of a washed rind cheeses."))
                     (relation-asserted which-washed-rind-cheese)
                     (valid-answers Taleggio other))))

   ; ... if main meal is entrée

(defrule determine-which-entrée-omnivorous
   (food-style omnivorous)
   (main-meal-for-omnivorous-or-vegetarian entrée)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entrée grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), fish, meat, vegetables, fats "
                                       "or other?"))
                     (relation-asserted which-entrée-omnivorous)
                     (valid-answers grain legumes fish meat vegetables fats other))))

(defrule determine-which-entrée-vegetarian
   (food-style vegetarian)
   (main-meal-for-omnivorous-or-vegetarian entrée)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entrée grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), vegetables, vegetables fats "
                                       "(avocados, olive oil, peanut butter, nuts and seeds) or other?"))
                     (relation-asserted which-entrée-vegetarian)
                     (valid-answers grain legumes vegetables "vegetables fats" other))))

(defrule determine-which-entrée-vegan
   (main-meal-for-vegan entrée)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entrée grain (farro, arborio, wild rice, polenta), "
                                       "legumes (lentils, fava, chickpea, green beans), vegetables, vegetables fats "
                                       "(avocados, olive oil, peanut butter, nuts and seeds), or other?"))
                     (relation-asserted which-entrée-vegan)
                     (valid-answers grain legumes vegetables "vegetables fats" other))))

(defrule determine-which-vegetables
   (or (which-entrée-omnivorous vegetables)
       (which-entrée-vegetarian vegetables)
       (which-entrée-vegan vegetables))
   =>
   (assert (UI-state (display (str-cat "Does the vegetables are root (parsnips, carrots), grilled (peppers, onions, "
                                       "mushrooms) or other?"))
                     (relation-asserted which-vegetables)
                     (valid-answers root grilled other))))

(defrule determine-which-fish
   (which-entrée-omnivorous fish)
   =>
   (assert (UI-state (display (str-cat "Does the fish is shellfish (clams, scallops, lobster, crab), bluefish (salmon, "
                                        "trout, tuna) or other? 🦐 🐟"))
                     (relation-asserted which-fish)
                     (valid-answers shellfish bluefish other))))

(defrule determine-which-fats
   (which-entrée-omnivorous fats)
   =>
   (assert (UI-state (display (str-cat "Does the fats are vegetable (avocados, olive oil, peanut butter, nuts "
                                       "and seeds) or animal (duck/pork fat, dairy)?"))
                     (relation-asserted which-fats)
                     (valid-answers vegetable animal other))))

(defrule determine-which-meat
   (which-entrée-omnivorous meat)
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
   (or (which-entrée-omnivorous dessert)
       (which-entrée-vegetarian dessert))
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
