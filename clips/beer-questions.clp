
;;***********************
;;* BEER QUESTION RULES *
;;***********************

; random questions for user type and scenario recognition

(defrule random-question-to-determine-which-age
   (start)
   (not (which-age ?age))
   =>
   (set-strategy random)
   (assert (UI-state (display "How old are you? 🔞")
                     (why "Younger people tend to prefer less intense beers.")
                     (relation-asserted which-age)
                     (labels "18 to 23" "24 to 29" "30 or older")
                     (valid-answers 18-23 24-29 >=30))))

(defrule random-question-to-determine-whether-he-is-a-regular-beer-drinker
   (start)
   (not (regular-beer-drinker ?drinker))
   =>
   (set-strategy random)
   (assert (UI-state (display "Do you drink beer often? 🍺")
                     (why "Better start with more standard beers. On the other hand, you may be surprised!")
                     (relation-asserted regular-beer-drinker)
                     (labels "Yes, often" "No, now and then")
                     (valid-answers yes no))))

(defrule random-question-to-determine-whether-he-is-going-to-smoke
   (start)
   (not (smoker ?smoker))
   =>
   (set-strategy random)
   (assert (UI-state (display "Do you usually smoke while you drink? 🚬")
   					 (why "Beer may alter the taste of tobacco. Also, stronger beers pair well with tobacco flavor.")
                     (relation-asserted smoker)
                     (labels "Yes" "No")
                     (valid-answers yes no))))

(defrule random-question-to-determine-which-season
   (start)
   (not (which-season ?season))
   =>
   (set-strategy random)
   (assert (UI-state (display "What season is it? 🍁🌱🏖❄️")
                     (why "Weather conditions influence our perceptions and needs. The choice of a beer is among these.")
                     (relation-asserted which-season)
                     (labels "🍁 Autumn" "🌱 Spring" "🏖 Summer" "❄️ Winter")
                     (valid-answers autumn spring summer winter))))

; random questions for personal preferences recognition

(defrule random-question-to-determine-preferred-color
   (start)
   (not (preferred-color ?color))
   =>
   (set-strategy random)
   (assert (UI-state (display "Which colour of beer do you like best? 🍺")
                     (relation-asserted preferred-color)
                     (labels "Light, golden" "Amber, copper" "Brown" "Dark, almost black" "Any is fine")
                     (valid-answers pale amber brown dark "don't mind"))))

(defrule random-question-to-determine-preferred-alcohol
   (start)
   (not (preferred-alcohol ?alcohol))
   =>
   (set-strategy random)
   (assert (UI-state (display "How strong do you like your drinks? 🍹")
                     (relation-asserted preferred-alcohol)
                     (labels "Light" "Medium" "Strong" "Very strong" "Any is fine")
                     (valid-answers low mild high "very high" "don't mind"))))

(defrule random-question-to-determine-preferred-carbonation
   (start)
   (not (preferred-carbonation ?carbonation))
   =>
   (set-strategy random)
   (assert (UI-state (display "How fizzy do you like your drinks? 🍾")
                     (relation-asserted preferred-carbonation)
                     (labels "A little" "Moderately" "Very fizzy" "Any is fine")
                     (valid-answers low medium high "don't mind"))))

(defrule random-question-to-determine-preferred-flavor
   (start)
   (not (preferred-flavor ?flavor))
   =>
   (set-strategy random)
   (assert (UI-state (display "Which taste do you enjoy most? 😋")
                     (relation-asserted preferred-flavor)
                     (labels "Fresh and clean"
                             "Sweet"
                             "Bitter"
                             "Toasty, like coffee"
                             "Fruity"
                             "Spiced"
                             "Sour, tangy"
                             "Any is fine")
                     (valid-answers clean sweet bitter roasty fruity spicy sour "don't mind"))))

; depth questions for meal type recognition

(defrule determine-main-meal
   (which-age ?age)
   (smoker ?smoker)
   (which-season ?season)
   (preferred-color ?color)
   (preferred-flavor ?flavor)
   (preferred-alcohol ?alcohol)
   (regular-beer-drinker ?drinker)
   (preferred-carbonation ?carbonation)
   =>
   (set-strategy depth)
   (assert (UI-state (display "What are you eating with it? 🍽")
                     (relation-asserted main-meal)
                     (labels "🍕 Pizza" "🍲 A main dish" "🧀 Cheese" "🍰 Dessert" "Something else")
                     (valid-answers pizza entrée cheese dessert other))))

(defrule determine-pizza-topping
   (main-meal pizza)
   =>
   (assert (UI-state (display "What's on the pizza? 🍕")
                     (why (format nil "%s %n%s %n%s %n%s"
                                      (str-cat "🍕 _Classic_ topping pizzas pair well with crisp and clean beers. "
                                               "Complementary grain and cheese flavors balance hop character while "
                                               "remaining light on the palate.")
                                      (str-cat "🍕🥓 _Meat_ topping pizzas pair well with hoppy and bitter beers, which "
                                               "stands up to strong flavors and cut through fat to deliver a complex "
                                               "finish.")
                                      (str-cat "🍕🍆 _Vegetables_ topping pizzas pair well with sour beers which "
                                               "increases the perception of savoriness or with beers which contrasts "
                                               "the char of the oven-roasted vegetables.")
                                      (str-cat "🍕🧀 _Cheese_ topping pizzas pair well with fruity and spicy beers, "
                                               "thanks to their high carbonation which works overtime to cleanse the "
                                               "palate from a strong flavor.")))
                     (relation-asserted pizza-topping)
                     (labels "Classic (tomato, mozzarella)"
                             "🥓 Meat or cold cuts"
                             "🍆 Vegetables"
                             "🧀 Lots of cheese"
                             "Something else")
                     (valid-answers classic meat vegetables cheese other))))

(defrule determine-if-meat-topping-is-spicy
   (pizza-topping meat)
   =>
   (assert (UI-state (display "Is the meat spicy? 🌶")
                     (why (str-cat "Malty flavors highlight the roasted qualities of the meat, while sweetness works to "
                                   "neutralize capsaicin, the active component in chili peppers."))
                     (relation-asserted meat-topping-is-spicy)
                     (labels "Yes, spicy" "No")
                     (valid-answers yes no))))

(defrule determine-if-vegetables-topping-are-roasted
   (pizza-topping vegetables)
   =>
   (assert (UI-state (display "Are the vegetables roasted?")
                     (why "The roasted character of the beer complements the char on oven-roasted vegetables.")
                     (relation-asserted vegetables-topping-are-roasted)
                     (labels "Yes, roasted" "No")
                     (valid-answers yes no))))

(defrule determine-which-entree
   (main-meal entrée)
   =>
   (assert (UI-state (display "What is the dish mostly made of?")
                     (why (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                      "🌾 Complementary _grain_ flavors balance hops while remaining light on the palate."
                                      "🌱 _Legumes_ add richness to the beer while balancing salt and acidity."
                                      (str-cat "🐟🦐 _Fish_ (shellfish) pairs well with fruity and spicy beers, "
                                               "such as saisons and wheat beers.")
                                      "🥩🍖 _Meat_ pairs by type: rich meats with sour, tart beers; game birds with hoppy, bitter ales."
                                      "🍆🥦 _Vegetables_ pair well with sour beers (root) or dark, roasty beers (grilled)."
                                      "🥜 With _fats_ strong flavors, beer balances and allows for a complex finish."))
                     (relation-asserted which-entrée)
                     (labels "🌾 Grains (rice, farro, polenta…)"
                             "🌱 Legumes (lentils, chickpeas, beans…)"
                             "🐟 Fish or seafood"
                             "🥩 Meat"
                             "🥦 Vegetables"
                             "🥑 Rich in fats (avocado, nuts, oil…)"
                             "Something else")
                     (valid-answers grain legumes fish meat vegetables fats other))))

(defrule determine-which-fish
   (which-entrée fish)
   =>
   (assert (UI-state (display "What kind of fish? 🐟")
                     (relation-asserted which-fish)
                     (labels "🦐 Shellfish or molluscs" "🐟 Other fish")
                     (valid-answers shellfish other))))

(defrule determine-if-shellfish-is-mild
   (which-fish shellfish)
   =>
   (assert (UI-state (display "Is it squid, cuttlefish or octopus? 🐙🦑")
                     (relation-asserted shellfish-is-mild)
                     (labels "Yes" "No, something else")
                     (valid-answers yes no))))

(defrule determine-which-shellfish
   (shellfish-is-mild no)
   =>
   (assert (UI-state (display "Which shellfish is it? 🦐🦀🐚")
                     (relation-asserted which-shellfish)
                     (labels "Mussels" "Oysters" "Something else")
                     (valid-answers mussels oysters other))))

(defrule determine-which-meat
   (which-entrée meat)
   =>
   (assert (UI-state (display "What kind of meat? 🍖")
                     (relation-asserted which-meat)
                     (labels "🥩 Red meat (beef, lamb, pork)" "🐔 Poultry" "🦌 Game" "Something else")
                     (valid-answers rich poultry game other))))

(defrule determine-which-meat-cooking-method
   (which-meat ?meat)
   =>
   (assert (UI-state (display "How is the meat cooked?")
                     (relation-asserted meat-cooking-method)
                     (labels "Braised or stewed" "Grilled" "Roasted" "Another way")
                     (valid-answers braised grilled roasted other))))

(defrule determine-which-rich
   (which-meat rich)
   =>
   (assert (UI-state (display "Which red meat?")
                     (relation-asserted which-rich)
                     (labels "Beef" "Lamb" "Pork" "Something else")
                     (valid-answers beef lamb pork other))))

(defrule determine-which-beef
   (which-rich beef)
   =>
   (assert (UI-state (display "Which beef?")
                     (relation-asserted which-beef)
                     (labels "Bresaola" "Other beef")
                     (valid-answers bresaola other))))

(defrule determine-which-pork
   (which-rich pork)
   =>
   (assert (UI-state (display "Which pork?")
                     (relation-asserted which-pork)
                     (labels "Loin" "Prosciutto" "Speck" "Mortadella" "Sausage or salami" "Something else")
                     (valid-answers loin prosciutto speck mortadella sausage other))))

(defrule determine-which-sausage
   (which-pork sausage)
   =>
   (assert (UI-state (display "Which cured meat?")
                     (relation-asserted which-sausage)
                     (labels "Capocollo" "Soppressata" "Spicy salami" "Something else")
                     (valid-answers capocollo soppressata "salame piccante" other))))

(defrule determine-which-poultry
   (which-meat poultry)
   =>
   (assert (UI-state (display "Which poultry? 🦃")
                     (relation-asserted which-poultry)
                     (labels "Chicken" "Other (turkey, duck…)")
                     (valid-answers chicken other))))

(defrule determine-which-game
   (which-meat game)
   =>
   (assert (UI-state (display "Which game?")
                     (relation-asserted which-game)
                     (labels "Ground game (boar, venison…)" "Game birds (duck, quail…)")
                     (valid-answers wild birds))))

(defrule determine-which-vegetables
   (which-entrée vegetables)
   =>
   (assert (UI-state (display "Which vegetables? 🥕🥗")
                     (relation-asserted which-vegetables)
                     (labels "🥕 Root vegetables (carrots, parsnips…)" "🥗 Other vegetables")
                     (valid-answers root other))))

(defrule determine-which-vegetables-cooking-method
   (which-vegetables ?vegetable)
   =>
   (assert (UI-state (display "How are the vegetables cooked?")
                     (relation-asserted vegetables-cooking-method)
                     (labels "Grilled" "Another way")
                     (valid-answers grilled other))))

(defrule determine-which-other-vegetables
   (which-vegetables other)
   =>
   (assert (UI-state (display "Are they mushrooms? 🍄")
                     (relation-asserted which-other-vegetables)
                     (labels "🍄 Mushrooms" "Something else")
                     (valid-answers mushrooms other))))

(defrule determine-which-fats
   (which-entrée fats)
   =>
   (assert (UI-state (display "Where does the fat come from? 🥑🍖")
                     (why "Carbonation is an effective tool to cleanse vegetable fats.")
                     (relation-asserted which-fats)
                     (labels "🥑 Plants (avocado, olive oil, nuts…)" "🍖 Animal or other")
                     (valid-answers vegetable other))))

(defrule determine-which-cheese-style
   (main-meal cheese)
   =>
   (assert (UI-state (display "What kind of cheese? 🧀")
                     (help (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                       (str-cat "🧀 _Fresh_ cheeses have not been aged, or are very slightly cured. "
                                                "These cheeses have a high moisture content and are usually mild and "
                                                "have a very creamy taste and soft texture.")
                                       (str-cat "🧀 _Semi-soft_ cheeses have a smooth, generally, "
                                                "creamy interior with little or no rind. These cheeses are generally "
                                                "high in moisture content and range from very mild in flavor to very "
                                                "pungent.")
                                       (str-cat "🧀 _Firm/hard_ cheeses have a taste profiles range "
                                                "from very mild to sharp and pungent. They generally have a texture "
                                                "profile that ranges from elastic, at room temperature, to the hard "
                                                "cheeses that can be grated.")
                                       (str-cat "🧀 _Blue_ cheeses have a distinctive blue/green "
                                                "veining, created when the penicillium roqueforti mold, added during the "
                                                "make process, is exposed to air. This mold provides a distinct flavor "
                                                "to the cheese, which ranges from fairly mild to assertive and pungent.")
                                       (str-cat "🧀 _Natural rind_ cheeses have rinds that are "
                                                "self-formed during the aging process. Generally, no molds or microflora "
                                                "are added, nor is washing used to create the exterior rinds, and those "
                                                "that do exhibit molds and microflora in their rinds get them naturally "
                                                "from the environment.")
                                       (str-cat "🧀 _Washed rind_ cheeses are surface-ripened by "
                                                "washing the cheese throughout the ripening/aging process with brine, "
                                                "beer, wine, brandy, or a mixture of ingredients, which encourages the "
                                                "growth of bacteria. The exterior rind of washed rind cheeses may vary "
                                                "from bright orange to brown, with flavor and aroma profiles that are "
                                                "quite pungent, yet the interior of these cheeses is most often "
                                                "semi-soft and, sometimes, very creamy.")))
                     (why (format nil "%s %n%s %n%s %n%s %n%s %n%s"
                                      (str-cat "🧀 _Fresh_ cheeses are light cheeses which pair excellently with the "
                                               "softer flavors of Wheat and Lambic beers.")
                                      (str-cat "🧀 _Semi-soft_ cheeses can be paired with many different craft beers, "
                                               "such as German Kölsch or Bock and Pale Ale beers.")
                                      (str-cat "🧀 _Firm/hard_ cheeses are easily paired with an equally broad range of "
                                               "craft beer styles, such as Pilsner, Bock, Brown Ale and Imperial Stout.")
                                      (str-cat "🧀 _Blue_ cheeses are stronger-flavored cheeses which are most "
                                               "successfully balanced with stonger-flavored bolder beers like IPAs or "
                                               "Imperial IPAs.")
                                      (str-cat "🧀 _Natural rind_ cheeses pair well with Golden, Blonde and traditional "
                                               "British-style ales.")
                                      (str-cat "🧀 _Washed rind_ cheeses, while potentially pungent, are often creamy "
                                               "and can be paired with Belgian-styles ales, like Triples and Golden "
                                               "Strong ales with these varieties.")))
                     (relation-asserted which-cheese-style)
                     (labels "Fresh (ricotta, mascarpone, feta…)"
                             "Soft (mozzarella, fontina…)"
                             "Aged, hard (parmesan, cheddar…)"
                             "Blue (gorgonzola, roquefort…)"
                             "White rind (brie, camembert…)"
                             "Strong-smelling (taleggio…)"
                             "Not sure")
                     (valid-answers fresh semi-soft firm/hard blue "natural rind" "washed rind" "don't know"))))

(defrule determine-which-fresh-cheese
   (which-cheese-style fresh)
   =>
   (assert (UI-state (display "Which fresh cheese? 🧀")
                     (why (str-cat "🧀 Italian-Style Mascarpone, Ricotta and soft Chèvre will match the delicate notes "
                                   "of the beer and neither will overwhelm the palate in the beginning of a meal."))
                     (relation-asserted which-fresh-cheese)
                     (labels "Mascarpone" "Goat's cheese" "Feta" "Cream cheese" "Something else")
                     (valid-answers Mascarpone Chèvre Feta "Cream Cheese" other))))

(defrule determine-which-semi-soft-cheese
   (which-cheese-style semi-soft)
   =>
   (assert (UI-state (display "Which soft cheese? 🧀")
                     (why (str-cat "🧀 Fontina, Havarti and milder blue cheeses can be enhanced by the carbonation of "
                                   "Kölsch style ales. The gentle notes of grass in the cheese can be brought out by "
                                   "using the malt of a Bock or the hops of a Pale Ale."))
                     (relation-asserted which-semi-soft-cheese)
                     (labels "Mozzarella" "Colby" "Havarti" "Monterey Jack" "Something else")
                     (valid-answers Mozzarella Colby Havarti "Monterey Jack" other))))

(defrule determine-which-firm-hard-cheese
   (which-cheese-style firm/hard)
   =>
   (assert (UI-state (display "Which hard cheese? 🧀")
                     (why (str-cat "🧀 Cheddar and Swiss cheeses can mimic the Maillard reaction when paired with a beer "
                                   "style, such as a Brown Ale. Roasty stouts can add a creaminess to the firm and hard "
                                   "cheeses on the palate."))
                     (relation-asserted which-firm/hard-cheese)
                     (labels "Gouda" "Cheddar" "Swiss (Emmental, Gruyère…)" "Parmesan" "Something else")
                     (valid-answers Gouda Cheddar Swiss Parmesan other))))

(defrule determine-which-type-of-Gouda
   (which-firm/hard-cheese Gouda)
   =>
   (assert (UI-state (display "What kind of Gouda? 🧀")
                     (relation-asserted which-type-of-Gouda)
                     (labels "Aged" "Smoked" "Neither")
                     (valid-answers aged smoked other))))

(defrule determine-which-color-of-Cheddar
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (UI-state (display "Is the Cheddar white? 🧀")
                     (relation-asserted which-color-of-Cheddar)
                     (labels "White" "Orange or not sure")
                     (valid-answers white other))))

(defrule determine-which-Cheddar-seasoning
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (UI-state (display "How aged is the Cheddar? 🧀")
                     (relation-asserted which-Cheddar-seasoning)
                     (labels "Young, mild" "Medium-aged" "Well aged" "Not sure")
                     (valid-answers mild medium aged other))))

(defrule determine-which-type-of-Swiss
   (which-firm/hard-cheese Swiss)
   =>
   (assert (UI-state (display "Which Swiss cheese? 🧀")
                     (why (str-cat "🧀 Emmentaler-style cheeses can mimic the Maillard reaction when paired with a beer "
                                   "style, such as a Brown Ale."))
                     (relation-asserted which-type-of-Swiss)
                     (labels "Emmental" "Gruyère" "Something else")
                     (valid-answers Emmental Gruyère other))))

(defrule determine-which-blue-cheese
   (which-cheese-style blue)
   =>
   (assert (UI-state (display "Which blue cheese? 🧀")
                     (why "🧀 Stilton cheese can be intensified the sweetness on the palate with a Barley Wine.")
                     (relation-asserted which-blue-cheese)
                     (labels "Stilton" "Another one (gorgonzola…)")
                     (valid-answers Stilton other))))

(defrule determine-which-natural-rind-cheese
   (which-cheese-style "natural rind")
   =>
   (assert (UI-state (display "Which white-rind cheese? 🧀")
                     (why (str-cat "🧀 Lancashire, Stilton, Brie and Camembert all share a rich creamy base that can be "
                                   "refreshed with a Golden, Blond or Pale Ale or intensified the sweetness on the "
                                   "palate with a Barley Wine."))
                     (relation-asserted which-natural-rind-cheese)
                     (labels "Brie" "Camembert" "Triple Crème" "Mimolette" "Stilton" "Something else")
                     (valid-answers Brie Camembert "Triple Crème" Mimolette Stilton other))))

(defrule determine-which-washed-rind-cheese
   (which-cheese-style "washed rind")
   =>
   (assert (UI-state (display "Is it Taleggio? 🧀")
                     (why (str-cat "🧀 Classic Belgian yeast flavors spur a tighter carbonation as well as bring out "
                                   "delicate sweet notes that can cut through the funk of a washed rind cheeses."))
                     (relation-asserted which-washed-rind-cheese)
                     (labels "Taleggio" "Another one")
                     (valid-answers Taleggio other))))

(defrule determine-which-dessert
   (main-meal dessert)
   =>
   (assert (UI-state (display "What kind of dessert? 🍮🥧🍪🍫")
                     (relation-asserted which-dessert)
                     (labels "🍮 Creamy (custard, cheesecake…)" "🥧 Fruit" "🍫 Chocolate" "Something else")
                     (valid-answers creamy fruit chocolate other))))

(defrule determine-if-creamy-dessert-is-fruit
   (which-dessert creamy)
   =>
   (assert (UI-state (display "Does it have fruit in it?")
                     (relation-asserted creamy-dessert-with-fruit)
                     (labels "Yes" "No")
                     (valid-answers yes no))))

(defrule determine-which-chocolate-dessert
   (which-dessert chocolate)
   =>
   (assert (UI-state (display "What kind of chocolate? 🍫")
                     (relation-asserted which-chocolate)
                     (labels "White" "Milk" "Dark, mild" "Dark, intense" "Pure cocoa, no sugar" "Not sure")
                     (valid-answers white milk semisweet bittersweet unsweetened/bitter "don't know"))))
