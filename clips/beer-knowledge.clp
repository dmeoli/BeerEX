
(defrule food-intolerance-is-gluten
   (food-intolerance gluten)
   =>
   (assert (attribute (name best-name) (value "Gluten Free") (certainty 50))))

(defrule food-intolerance-is-yeast
   (food-intolerance yeast)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 50)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 50))))

(defrule chocolate-for-omnivorous-or-vegetarian-yeast-intolerant-is-bittersweet
   (chocolate-for-omnivorous-or-vegetarian-yeast-intolerant bittersweet)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90))))

(defrule chocolate-for-yeast-intolerant-is-unsweetened/bitter
   (or (chocolate-for-omnivorous-or-vegetarian-yeast-intolerant unsweetened/bitter)
       (chocolate-for-vegan-yeast-intolerant-is-unsweetened/bitter yes))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90))))

(defrule preferred-alcohol-is-low
   (preferred-alcohol low)
   =>
   (assert (attribute (name best-alcohol) (value not-detectable) (certainty 20))))

(defrule preferred-alcohol-is-mild
   (preferred-alcohol mild)
   =>
   (assert (attribute (name best-alcohol) (value mild) (certainty 20))))

(defrule preferred-alcohol-is-high
   (preferred-alcohol high)
   =>
   (assert (attribute (name best-alcohol) (value noticeable) (certainty 20))))

(defrule preferred-alcohol-is-very-high
   (preferred-alcohol "very high")
   =>
   (assert (attribute (name best-alcohol) (value harsh) (certainty 20))))

(defrule driver-is-yes
   (driver yes)
   =>
   (assert (attribute (name best-alcohol) (value not-detectable) (certainty 70)))
   (assert (attribute (name best-alcohol) (value mild) (certainty 35))))

(defrule preferred-color-is-any
   (preferred-color ?color)
   =>
   (assert (attribute (name best-color) (value ?color) (certainty 20))))

(defrule preferred-carbonation-is-any
   (preferred-carbonation ?carbonation)
   =>
   (assert (attribute (name best-carbonation) (value ?carbonation) (certainty 20))))

(defrule smoker-is-yes
   (smoker yes)
   =>
   (assert (attribute (name best-name) (value "Smoke Porter") (certainty 20)))
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 20))))

(defrule fermented-foods-eater-is-yes
   (fermented-foods-eater yes)
   =>
   (assert (attribute (name best-fermentation) (value wild) (certainty 20))))

(defrule preferred-wine-is-Chardonnay
   (preferred-wine Chardonnay)
   =>
   (assert (attribute (name best-style) (value "Wheat Beer") (certainty 10))))

(defrule preferred-wine-is-Pinot-Noir
   (preferred-wine "Pinot Noir")
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 10)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 10))))

(defrule preferred-wine-is-Pinot-Gris
   (preferred-wine "Pinot Gris")
   =>
   (assert (attribute (name best-style) (value "Pilsener & Pale Lager") (certainty 10))))

(defrule preferred-wine-is-Sauvignon-Blanc
   (preferred-wine "Sauvignon Blanc")
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "German-Style Kölsch") (certainty 10))))

(defrule preferred-wine-is-Cabernet-Sauvignon
   (preferred-wine "Cabernet Sauvignon")
   =>
   (assert (attribute (name best-style) (value "Stout") (certainty 10))))

(defrule preferred-wine-is-Merlot
   (preferred-wine Merlot)
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 10))))

(defrule preferred-wine-is-Malbec
   (preferred-wine Malbec)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 10))))

(defrule preferred-wine-is-Zinfandels
   (preferred-wine Zinfandels)
   =>
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "American Imperial Red Ale") (certainty 10))))

(defrule preferred-wine-is-Syrah
   (preferred-wine Syrah)
   =>
   (assert (attribute (name best-style) (value "Porter") (certainty 10))))

(defrule preferred-wine-is-Chianti
   (preferred-wine Chianti)
   =>
   (assert (attribute (name best-style) (value "Pilseners & Pale Lager") (certainty 10)))
   (assert (attribute (name best-style) (value "Dark Lager") (certainty 10))))

(defrule preferred-wine-is-Port
   (preferred-wine Port)
   =>
   (assert (attribute (name best-name) (value "Barrel-Aged Beer") (certainty 10))))

(defrule preferred-flavor-is-clean
   (preferred-flavor clean)
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 20))))

(defrule preferred-flavor-is-sweet
   (preferred-flavor sweet)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 20))))

(defrule preferred-aroma-for-sweet-flavor-is-toasty
   (preferred-aroma-for-sweet-flavor toasty)
   =>
   (assert (attribute (name best-name) (value "English-Style Mild") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Schwarzbier") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Dunkelweizen") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Brown Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Bock") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 20))))

(defrule preferred-aroma-for-sweet-flavor-is-caramelly
   (preferred-aroma-for-sweet-flavor caramelly)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 20)))
   (assert (attribute (name best-name) (value "Scottish-Style Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Irish-Style Red") (certainty 20)))
   (assert (attribute (name best-name) (value "French-Style Biére de Garde") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 20)))
   (assert (attribute (name best-name) (value "Scotch Ale/Wee Heavy") (certainty 20))))

(defrule preferred-flavor-is-roasty
   (preferred-flavor roasty)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 20))))

(defrule preferred-aroma-for-roasty-flavor-is-malty
   (preferred-aroma-for-roasty-flavor malty)
   =>
   (assert (attribute (name best-name) (value "German-Style Schwarzbier") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 20)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Oatmeal Stout") (certainty 20)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Brown Ale") (certainty 20))))

(defrule preferred-aroma-for-roasty-flavor-is-dry
   (preferred-aroma-for-roasty-flavor dry)
   =>
   (assert (attribute (name best-name) (value "Irish-Style Dry Stout") (certainty 20)))
   (assert (attribute (name best-name) (value "American Black Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American Stout") (certainty 20)))
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 20))))

(defrule preferred-flavor-is-bitter
   (preferred-flavor bitter)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 20))))

(defrule preferred-aroma-for-bitter-flavor-is-earthy
   (preferred-aroma-for-bitter-flavor earthy)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 20)))
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American IPA") (certainty 20))))

(defrule preferred-aroma-for-bitter-flavor-is-malt-forward
   (preferred-aroma-for-bitter-flavor malt-forward)
   =>
   (assert (attribute (name best-name) (value "California Common") (certainty 20)))
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American Barley Wine") (certainty 20))))

(defrule preferred-aroma-for-bitter-flavor-is-strong-hop
   (preferred-aroma-for-bitter-flavor strong-hop)
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Imperial IPA") (certainty 20))))

(defrule preferred-flavor-is-fruity
   (preferred-flavor fruity)
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 20))))

(defrule preferred-aroma-for-fruity-or-spicy-flavor-is-brighter
   (or (preferred-aroma-for-fruity-flavor brighter)
       (preferred-aroma-for-spicy-flavor brighter))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Witbier") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Hefeweizen") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 20))))

(defrule preferred-aroma-for-fruity-or-spicy-flavor-is-darker
   (or (preferred-aroma-for-fruity-flavor darker)
       (preferred-aroma-for-spicy-flavor darker))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Quadrupel") (certainty 20))))

(defrule preferred-aroma-for-sour-flavor-is-light
   (preferred-aroma-for-sour-flavor light)
   =>
   (assert (attribute (name best-name) (value "Berliner-Style Weisse") (certainty 20))))

(defrule preferred-aroma-for-sour-flavor-is-medium
   (preferred-aroma-for-sour-flavor medium)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 20)))
   (assert (attribute (name best-name) (value "American Brett") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 20))))

(defrule preferred-aroma-for-sour-flavor-is-strong
   (preferred-aroma-for-sour-flavor strong)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 20)))
   (assert (attribute (name best-name) (value "American Brett") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 20))))

(defrule main-meal-is-grain
   (or (main-meal-omnivorous grain)
       (main-meal-vegetarian grain)
       (main-meal-vegan grain))
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 40))))

(defrule main-meal-is-legumes
   (or (main-meal-omnivorous legumes)
       (main-meal-vegetarian legumes)
       (main-meal-vegan legumes))
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 40))))

(defrule main-meal-is-fats
   (or (main-meal-omnivorous fats)
       (main-meal-vegetarian "vegetable fats")
       (main-meal-vegan "vegetable fats"))
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 80)))
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 40))))

(defrule which-fish-is-shellfish
   (which-fish shellfish)
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 40))))

(defrule which-vegetables-is-root
   (which-vegetables root)
   =>
   (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 70))))

(defrule which-vegetables-is-grilled
   (which-vegetables grilled)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 70))))

(defrule which-meat-is-rich-meats
   (which-meat "rich meats")
   =>
   (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 70))))

(defrule which-meat-is-game-birds
   (which-meat "game birds")
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 70))))

(defrule which-meat-is-braised-meats
   (which-meat "braised meats")
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 70)))
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 70))))

(defrule which-meat-is-pork
   (which-meat pork)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 70)))
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 70))))

(defrule which-pork-is-prosciutto
   (which-pork prosciutto)
   =>
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 90))))

(defrule which-pork-is-speck
   (which-pork speck)
   =>
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 90)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90))))

(defrule which-pork-is-mortadella
   (which-pork mortadella)
   =>
   (assert (attribute (name best-name) (value "German-Style Märzen/Oktoberfest") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 90))))

(defrule which-sausage-is-capocollo
   (which-sausage capocollo)
   =>
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 90))))

(defrule which-sausage-is-soppressata
   (which-sausage soppressata)
   =>
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 90))))

(defrule which-sausage-is-salame-piccante
   (which-sausage "salame piccante")
   =>
   (assert (attribute (name best-name) (value "Imperial IPA") (certainty 90)))
   (assert (attribute (name best-name) (value "Rye Beer") (certainty 90))))

(defrule which-cheese-is-fresh
   (which-cheese fresh)
   =>
   (assert (attribute (name best-style) (value "Wheat Beer") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90))))

(defrule which-cheese-is-semi-soft
   (which-cheese semi-soft)
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 90)))
   (assert (attribute (name best-style) (value "Bock") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Kölsch") (certainty 90))))

(defrule which-cheese-is-firm/hard
   (which-cheese firm/hard)
   =>
   (assert (attribute (name best-style) (value "Bock") (certainty 90)))
   (assert (attribute (name best-style) (value "Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 90))))

(defrule which-cheese-is-blue
   (which-cheese blue)
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 90))))

(defrule which-cheese-is-natural-rind
   (which-cheese "natural rind")
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "American Barley Wine") (certainty 90)))
   (assert (attribute (name best-name) (value "British-Style Barley Wine Ale") (certainty 90))))

(defrule which-cheese-is-washed-rind
   (which-cheese "washed rind")
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 90))))

(defrule which-fats-is-vegetable
   (or (which-fats vegetable)
       (main-meal-vegetarian "vegetables fats")
       (main-meal-vegan "vegetables fats"))
   =>
   (assert (attribute (name best-carbonation) (value high) (certainty 80)))
   (assert (attribute (name best-carbonation) (value medium) (certainty 40))))

(defrule which-chocolate-is-white
   (which-chocolate white)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Witbier") (certainty 90)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90))))

(defrule which-chocolate-is-milk
   (which-chocolate milk)
   =>
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 90)))
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 90))))

(defrule which-chocolate-is-semisweet
   (which-chocolate semisweet)
   =>
   (assert (attribute (name best-name) (value "American Stout") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 90)))
   (assert (attribute (name best-name) (value "American IPA") (certainty 90))))

(defrule which-chocolate-is-bittersweet
   (which-chocolate bittersweet)
   =>
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Quadrupel") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90))))

(defrule which-chocolate-is-unsweetened/bitter-or-main-meal-vegan-is-chocolate
   (or (which-chocolate unsweetened/bitter)
       (main-meal-vegan chocolate))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "American Sour") (certainty 90))))

(defrule predominant-dish-taste-is-sweet
   (predominant-dish-taste sweet)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 60))))

(defrule predominant-dish-taste-is-acid
   (predominant-dish-taste acid)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60))))

(defrule predominant-dish-taste-is-spice
   (predominant-dish-taste spice)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60)))
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 60))))

(defrule predominant-dish-taste-is-umami
   (predominant-dish-taste umami)
   =>
   (assert (attribute (name best-carbonation) (value medium) (certainty 30)))
   (assert (attribute (name best-carbonation) (value high) (certainty 60))))

(defrule main-meal-is-fats-and-predominant-dish-taste-is-sweet
   (or (main-meal-omnivorous fats)
       (main-meal-vegetarian "vegetable fats")
       (main-meal-vegan "vegetable fats"))
   (predominant-dish-taste sweet)
   =>
   (assert (attribute (name best-alcohol) (value harsh) (certainty 30)))
   (assert (attribute (name best-alcohol) (value noticeable) (certainty 15))))

(defrule dish-cooking-method-is-dry-heat
   (dish-cooking-method dry-heat)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60))))