
;;***********************
;;* BEER QUESTION RULES *
;;***********************

; random questions for user type and scenario recognition

(defrule determine-which-sex
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Are you male or female?")
                     (relation-asserted which-sex)
                     (valid-answers male female))))

(defrule determine-which-age
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "How old are you?")
                     (relation-asserted which-age)
                     (valid-answers <=18 18-22 22-25 25-30 30-40 >=40))))

(defrule determine-which-season
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "It is autumn, spring, summer or winter?")
                     (relation-asserted which-season)
                     (valid-answers autumn spring summer winter))))

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

(defrule determine-whether-he-eats-fermented-foods
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Do you generally eat fermented foods (probiotic yogurt, kefir, kombucha, etc.)? 🍶")
                     (relation-asserted fermented-foods-eater)
                     (valid-answers yes no))))

(defrule determine-whether-he-should-drive
   (declare (salience ?*very-high-priority*))
   (start)
   =>
   (assert (UI-state (display "Do you have to drive? 🚘")
                     (relation-asserted driver)
                     (valid-answers yes no))))

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

   ; ... if main meal is pizza

(defrule determine-pizza-for-omnivorous
   (food-style omnivorous)
   (main-meal-for-omnivorous-or-vegetarian pizza)
   =>
   (assert (UI-state (display "Is the pizza topping classic, meat, vegetables, cheese or other?")
                     (relation-asserted pizza-topping-for-omnivorous)
                     (valid-answers classic meat vegetables cheese other))))

(defrule determine-if-meat-topping-is-spicy
   (pizza-topping-for-omnivorous meat)
   =>
   (assert (UI-state (display "Is the meat spicy?")
                     (relation-asserted meat-topping-is-spicy)
                     (valid-answers yes no))))

(defrule determine-pizza-for-vegetarian
   (food-style vegetarian)
   (main-meal-for-omnivorous-or-vegetarian pizza)
   =>
   (assert (UI-state (display "Is the pizza topping classic, vegetables, cheese or other?")
                     (relation-asserted pizza-topping-for-vegetarian)
                     (valid-answers classic vegetables cheese other))))

(defrule determine-pizza-for-vegan
   (main-meal-for-vegan pizza)
   =>
   (assert (UI-state (display "Is the pizza topping classic, vegetables or other?")
                     (relation-asserted pizza-topping-for-vegan)
                     (valid-answers classic vegetables other))))

(defrule determine-if-vegetables-topping-are-roasted
   (or (pizza-topping-for-omnivorous vegetables)
       (pizza-topping-for-vegetarian vegetables)
       (pizza-topping-for-vegan vegetables))
   =>
   (assert (UI-state (display "Are the vegetables roasted?")
                     (relation-asserted vegetables-topping-are-roasted)
                     (valid-answers yes no))))

   ; ... if main meal is cheese

(defrule determine-which-cheese-style
   (main-meal-for-omnivorous-or-vegetarian cheese)
   =>
   (assert (UI-state (display (str-cat "Is the cheese style fresh (Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese, "
                                       "Quark, Cottage, etc.), semi-soft (Mozzarella, Colby, Fontina, Havarti, Monterey "
                                       "Jack, etc.), firm/hard (Gouda, Cheddar, Swiss, Parmesan), blue (Roquefort, "
                                       "Gorgonzola, Danish, etc.), natural rind (Brie, Camembert, Triple Crème, "
                                       "Mimolette, Stilton, Lancashire, Tomme de Savoie, etc.) or washed rind (Epoisses, "
                                       "Livarot, Taleggio, etc.)? 🧀"))
                     (help (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                       (str-cat "🧀 _Fresh_ cheeses have not been aged, or are very slightly cured. These "
                                                "cheeses have a high moisture content and are usually mild and have a "
                                                "very creamy taste and soft texture.")
                                       (str-cat "🧀 [Semi-soft](www.goo.gl/izu1Bw) cheeses have a smooth, generally, "
                                                "creamy interior with little or no rind. These cheeses are generally "
                                                "high in moisture content and range from very mild in flavor to very "
                                                "pungent.")
                                       (str-cat "🧀 [Firm/hard](www.goo.gl/yrfoJK) cheeses have a taste profiles range "
                                                "from very mild to sharp and pungent. They generally have a texture "
                                                "profile that ranges from elastic, at room temperature, to the hard "
                                                "cheeses that can be grated.")
                                       (str-cat "🧀 [Blue](www.goo.gl/9KkNww) cheeses have a distinctive blue/green "
                                                "veining, created when the penicillium roqueforti mold, added during the "
                                                "make process, is exposed to air. This mold provides a distinct flavor "
                                                "to the cheese, which ranges from fairly mild to assertive and pungent.")
                                       (str-cat "🧀 [Natural rind](www.goo.gl/ys8pkz) cheeses have rinds that are "
                                                "self-formed during the aging process. Generally, no molds or microflora "
                                                "are added, nor is washing used to create the exterior rinds, and those "
                                                "that do exhibit molds and microflora in their rinds get them naturally "
                                                "from the environment.")
                                       (str-cat "🧀 [Washed rind](www.goo.gl/Kh3BwD) cheeses are surface-ripened by "
                                                "washing the cheese throughout the ripening/aging process with brine, "
                                                "beer, wine, brandy, or a mixture of ingredients, which encourages the "
                                                "growth of bacteria. The exterior rind of washed rind cheeses may vary "
                                                "from bright orange to brown, with flavor and aroma profiles that are "
                                                "quite pungent, yet the interior of these cheeses is most often "
                                                "semi-soft and, sometimes, very creamy.")))
                     (why (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                      (str-cat "🧀 Fresh cheeses are light cheeses which pair excellently with the "
                                               "softer flavors of Wheat and Lambic beers.")
                                      (str-cat "🧀 [Semi-soft](www.goo.gl/izu1Bw) cheeses can be paired with many "
                                               "different craft beers, such as German Kölsch or Bock and Pale Ale beers.")
                                      (str-cat "🧀 [Firm/hard](www.goo.gl/yrfoJK) cheeses are easily paried with an "
                                               "equally broad range of craft beer styles, such as Pilsner, Bock, Brown "
                                               "Ale and Imperial Stout.")
                                      (str-cat "🧀 [Blue](www.goo.gl/9KkNww) cheeses are stronger-flavored cheeses which "
                                               "are most successfully balanced with stonger-flavored bolder beers like "
                                               "IPAs or Imperial IPAs.")
                                      (str-cat "🧀 [Natural rind](www.goo.gl/ys8pkz) cheeses pair well with Golden, "
                                               "Blonde and traditional British-style ales.")
                                      (str-cat "🧀 [Washed rind](www.goo.gl/Kh3BwD) cheeses, while potentially pungent, "
                                               "are often creamy and can be paired with Belgian-styles ales, like "
                                               "Triples and Golden Strong ales with these varieties.")))
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

(defrule determine-which-semi-soft-cheese
   (which-cheese-style semi-soft)
   =>
   (assert (UI-state (display "Is the semi-soft cheese Mozzarella, Colby, Havarti, Monterey Jack or other? 🧀")
                     (why (str-cat "🧀 Fontina, Havarti and milder blue cheeses can be enhanced by the carbonation of "
                                   "Kölsch style ales. The gentle notes of grass in the cheese can be brought out by "
                                   "using the malt of a Bock or the hops of a Pale Ale."))
                     (relation-asserted which-semi-soft-cheese)
                     (valid-answers Mozzarella Colby Havarti "Monterey Jack" other))))

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

(defrule determine-if-Swiss-is-aged
   (which-type-of-Swiss other)
   =>
   (assert (UI-state (display "Is the Swiss aged? 🧀")
                     (relation-asserted Swiss-is-aged)
                     (valid-answers yes no "don't know"))))

(defrule determine-which-blue-cheese
   (which-cheese-style blue)
   =>
   (assert (UI-state (display "Is the blue cheese Stilton or other? 🧀")
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
   (assert (UI-state (display (str-cat "Is the main component of the entrée grain (farro, arborio, wild rice, polenta, "
                                       "etc.), legumes (lentils, fava, chickpea, green beans, etc.), fish, meat, "
                                       "vegetables, fats or other?"))
                     (relation-asserted which-entrée-omnivorous)
                     (valid-answers grain legumes fish meat vegetables fats other))))

(defrule determine-which-entrée-vegetarian
   (food-style vegetarian)
   (main-meal-for-omnivorous-or-vegetarian entrée)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entrée grain (farro, arborio, wild rice, polenta, "
                                       "etc.), legumes (lentils, fava, chickpea, green beans, etc.), vegetables, "
                                       "vegetables fats (avocados, olive oil, peanut butter, nuts and seeds, etc.) or "
                                       "other?"))
                     (relation-asserted which-entrée-vegetarian)
                     (valid-answers grain legumes vegetables "vegetables fats" other))))

(defrule determine-which-entrée-vegan
   (main-meal-for-vegan entrée)
   =>
   (assert (UI-state (display (str-cat "Is the main component of the entrée grain (farro, arborio, wild rice, polenta, "
                                       "etc.), legumes (lentils, fava, chickpea, green beans, etc.), vegetables, "
                                       "vegetables fats (avocados, olive oil, peanut butter, nuts and seeds, etc.), or "
                                       "other?"))
                                       (help (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                                         (str-cat "🌾 Complementary _grain_ flavors balance hops while remaining light on the "
                                                                  "palate.")
                                                         (str-cat "🌱 _Beans_ add richness to the beer while balancing salt and acidity.")
                                                         (str-cat "🦐🦀 With _shellfish_ foods beers need to bring out salinity and natural  "
                                                                  "sweetness while cleansing the palate.")
                                                         (str-cat "🥩🥕 _Rich_ _meats_ and _root_ _vegetables_ flavors brings out umami and adds earthy "
                                                                  "notes that rest on the center of the palate.")
                                                         (str-cat "🦆🦃 _Game_ _birds_ roastiness and fat coats help neutralize hop bitterness. ")
                                                         (str-cat "🥜 With _fats_ strong flavors, beer balances and allows for a complex finish.")
                                                         (str-cat "🍆🍄 _Grilled_ _vegetables_ brings out umami and balances sweetnees and richness.")
                                                         (str-cat "🧀 Beer complements the natural flavor and textures of _cheese_ while cutting "
                                                                  "through fat, cleansing the palate.")
                                                         (str-cat "🥘🍫 With _braised_ _meats_ and _chocolate_, beer highlights the roasted character.")
                                                         (str-cat "🍖 The intensity of the _pork_ fat stands up to the strong beer characteristics.")
                                                         (str-cat "🍨🍮 Beer balances richness on the palate so the _dessert_ doesn't finish cloyingly.")))
                     (relation-asserted which-entrée-vegan)
                     (valid-answers grain legumes vegetables "vegetables fats" other))))

(defrule determine-which-grain
   (or (which-entrée-omnivorous grain)
       (which-entrée-vegetarian grain)
       (which-entrée-vegan grain))
   =>
   (assert (UI-state (display "Are the grain chips, spaghetti, bruschetta, grits or other?")
                     (relation-asserted which-grain)
                     (valid-answers chips spaghetti bruschetta grits other))))

(defrule determine-which-fish-cooking-method
   (which-entrée-omnivorous fish)
   =>
   (assert (UI-state (display "Is the fish cooking method grilled or other?")
                     (relation-asserted fish-cooking-method)
                     (valid-answers grilled other))))

(defrule determine-which-fish
   (which-entrée-omnivorous fish)
   =>
   (assert (UI-state (display (str-cat "Is the fish shellfish (clams, scallops, lobster, crab, etc.), bluefish (salmon, "
                                       "trout, tuna, etc.) or other? 🦑🐙🦐🐟"))
                     (relation-asserted which-fish)
                     (valid-answers shellfish bluefish other))))

(defrule determine-if-shellfish-is-mild
   (which-fish shellfish)
   =>
   (assert (UI-state (display "Is the shellfish mild (squid, cuttlefish, octopus)? 🦑🐙")
                     (relation-asserted shellfish-is-mild)
                     (valid-answers yes no))))

(defrule determine-which-shellfish
   (shellfish-is-mild no)
   =>
   (assert (UI-state (display "Are the fish shellfish shrimps, mussels, oysters or other? 🦐")
                     (relation-asserted which-shellfish)
                     (valid-answers shrimps mussels oysters other))))

(defrule determine-which-bluefish
   (which-fish bluefish)
   =>
   (assert (UI-state (display "Is the bluefish salmon or other?")
                     (relation-asserted which-bluefish)
                     (valid-answers salmon other))))

(defrule determine-which-meat-cooking-method
   (which-entrée-omnivorous meat)
   =>
   (assert (UI-state (display "Is the meat cooking method barbecue, braised, grilled, roasted or other?")
                     (relation-asserted meat-cooking-method)
                     (valid-answers barbecue braised grilled roasted other))))

(defrule determine-which-meat
   (which-entrée-omnivorous meat)
   =>
   (assert (UI-state (display "Is the meat rich (beef, lamb, pork, etc.), poultry, game, steak or other?")
                     (relation-asserted which-meat)
                     (valid-answers rich poultry game steak other))))

(defrule determine-which-rich
   (which-meat rich)
   =>
   (assert (UI-state (display "Is the rich meat beef, lamb, pork or other?")
                     (relation-asserted which-rich)
                     (valid-answers beef lamb pork other))))

(defrule determine-which-beef
   (which-rich beef)
   =>
   (assert (UI-state (display "Is the beef bresaola or other?")
                     (relation-asserted which-beef)
                     (valid-answers bresaola other))))

(defrule determine-which-pork
   (which-rich pork)
   =>
   (assert (UI-state (display "Is the pork loin, tenderloin, prosciutto, speck, mortadella, sausage or other?")
                     (relation-asserted which-pork)
                     (valid-answers loin tenderloin prosciutto speck mortadella sausage other))))

(defrule determine-which-sausage
   (which-pork sausage)
   =>
   (assert (UI-state (display "Is the sausage capocollo, soppressata, salame piccante or other?")
                     (relation-asserted which-sausage)
                     (valid-answers capocollo soppressata "salame piccante" other))))

(defrule determine-which-poultry
   (which-meat poultry)
   =>
   (assert (UI-state (display "Is the poultry chicken or turkey?")
                     (relation-asserted which-poultry)
                     (valid-answers chicken turkey))))

(defrule determine-which-game
   (which-meat game)
   =>
   (assert (UI-state (display "Is the game wild or birds (duck, quail, quinoa, etc.)?")
                     (relation-asserted which-game)
                     (valid-answers wild birds))))

(defrule determine-which-game-birds
   (which-game birds)
   =>
   (assert (UI-state (display "Is the game birds duck or other?")
                     (relation-asserted which-game-birds)
                     (valid-answers duck other))))

(defrule determine-which-vegetables-cooking-method
   (or (which-entrée-omnivorous vegetables)
       (which-entrée-vegetarian vegetables)
       (which-entrée-vegan vegetables))
   =>
   (assert (UI-state (display "Is the vegetables cooking method grilled, roasted or other?")
                     (relation-asserted vegetables-cooking-method)
                     (valid-answers grilled roasted other))))

(defrule determine-which-vegetables
   (or (which-entrée-omnivorous vegetables)
       (which-entrée-vegetarian vegetables)
       (which-entrée-vegan vegetables))
   =>
   (assert (UI-state (display "Is the vegetables root (parsnips, carrots, etc.), salad or other?")
                     (relation-asserted which-vegetables)
                     (valid-answers root salad other))))

(defrule determine-which-other-vegetables
   (which-vegetables other)
   =>
   (assert (UI-state (display "Are the vegetables mushrooms or other?")
                     (relation-asserted which-other-vegetables)
                     (valid-answers mushrooms other))))

(defrule determine-which-fats
   (which-entrée-omnivorous fats)
   =>
   (assert (UI-state (display (str-cat "Is the fats vegetable (avocados, olive oil, peanut butter, nuts and seeds, etc.) "
                                       "or animal (duck/pork fat, dairy, etc.)?"))
                     (why "Carbonation is an effective tool to cleanse non-animal fats.")
                     (relation-asserted which-fats)
                     (valid-answers vegetable animal other))))

   ; ... if main meal is dessert

(defrule determine-which-dessert
   (or (which-entrée-omnivorous dessert)
       (which-entrée-vegetarian dessert))
   =>
   (assert (UI-state (display (str-cat "Is the dessert creamy (cheesecake, ice cream, creme brûlée, mousse cake), "
                                       "chocolate or other? 🍫"))
                     (relation-asserted which-dessert)
                     (valid-answers creamy chocolate other))))

(defrule determine-which-chocolate
   (which-dessert chocolate)
   =>
   (assert (UI-state (display (str-cat "Is the chocolate white, milk (35% cacao ca.), semisweet (55% cacao ca.), "
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
;   (assert (UI-state (display (str-cat "Is the dish cooking method dry-heat (broiling, grilling, roasting, baking, "
;                                       "sautéing, pan-frying, deep-frying), moist-heat (poaching, simmering, boiling, "
;                                       "steaming) or it is a combination of both (braising, stewing)?"))
;                     (relation-asserted dish-cooking-method)
;                     (valid-answers dry-heat moist-heat combination "don't know"))))
