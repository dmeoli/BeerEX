
; determine best beer attributes for user type recognized

(defrule determine-best-beer-attributes-if-food-intolerance-is-gluten
   (declare (salience ?*medium-low-priority*))
   (food-intolerance gluten)
   =>
   (assert (attribute (name best-name) (value "Gluten Free") (certainty 50))))

(defrule determine-best-beer-attributes-if-food-intolerance-is-yeast
   (declare (salience ?*medium-low-priority*))
   (food-intolerance yeast)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 50)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 50))))

(defrule determine-best-beer-attributes-if-chocolate-for-omnivorous-or-vegetarian-yeast-intolerant-is-bittersweet
   (declare (salience ?*medium-low-priority*))
   (chocolate-for-omnivorous-or-vegetarian-yeast-intolerant bittersweet)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90))))

(defrule determine-best-beer-attributes-if-chocolate-for-yeast-intolerant-is-unsweetened/bitter
   (declare (salience ?*medium-low-priority*))
   (or (chocolate-for-omnivorous-or-vegetarian-yeast-intolerant unsweetened/bitter)
       (chocolate-for-vegan-yeast-intolerant-is-unsweetened/bitter yes))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90))))

(defrule determine-best-beer-attributes-if-preferred-alcohol-is-low
   (declare (salience ?*medium-low-priority*))
   (preferred-alcohol low)
   =>
   (assert (attribute (name best-alcohol) (value not-detectable) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-alcohol-is-mild
   (declare (salience ?*medium-low-priority*))
   (preferred-alcohol mild)
   =>
   (assert (attribute (name best-alcohol) (value mild) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-alcohol-is-high
   (declare (salience ?*medium-low-priority*))
   (preferred-alcohol high)
   =>
   (assert (attribute (name best-alcohol) (value noticeable) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-alcohol-is-very-high
   (declare (salience ?*medium-low-priority*))
   (preferred-alcohol "very high")
   =>
   (assert (attribute (name best-alcohol) (value harsh) (certainty 20))))

(defrule determine-best-beer-attributes-if-driver-is-yes
   (declare (salience ?*medium-low-priority*))
   (driver yes)
   =>
   (assert (attribute (name best-alcohol) (value not-detectable) (certainty 70)))
   (assert (attribute (name best-alcohol) (value mild) (certainty 35))))

(defrule determine-best-beer-attributes-if-preferred-color-is-any
   (declare (salience ?*medium-low-priority*))
   (preferred-color ?color)
   =>
   (assert (attribute (name best-color) (value ?color) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-carbonation-is-any
   (declare (salience ?*medium-low-priority*))
   (preferred-carbonation ?carbonation)
   =>
   (assert (attribute (name best-carbonation) (value ?carbonation) (certainty 20))))

(defrule determine-best-beer-attributes-if-smoker-is-yes
   (declare (salience ?*medium-low-priority*))
   (smoker yes)
   =>
   (assert (attribute (name best-name) (value "Smoke Porter") (certainty 20)))
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 20))))

(defrule determine-best-beer-attributes-if-fermented-foods-eater-is-yes
   (declare (salience ?*medium-low-priority*))
   (fermented-foods-eater yes)
   =>
   (assert (attribute (name best-fermentation) (value wild) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Chardonnay
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Chardonnay)
   =>
   (assert (attribute (name best-style) (value "Wheat Beer") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Pinot-Noir
   (declare (salience ?*medium-low-priority*))
   (preferred-wine "Pinot Noir")
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 10)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Pinot-Gris
   (declare (salience ?*medium-low-priority*))
   (preferred-wine "Pinot Gris")
   =>
   (assert (attribute (name best-style) (value "Pilsener & Pale Lager") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Sauvignon-Blanc
   (declare (salience ?*medium-low-priority*))
   (preferred-wine "Sauvignon Blanc")
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "German-Style Kölsch") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Cabernet-Sauvignon
   (declare (salience ?*medium-low-priority*))
   (preferred-wine "Cabernet Sauvignon")
   =>
   (assert (attribute (name best-style) (value "Stout") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Merlot
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Merlot)
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Malbec
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Malbec)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Zinfandels
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Zinfandels)
   =>
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "American Imperial Red Ale") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Syrah
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Syrah)
   =>
   (assert (attribute (name best-style) (value "Porter") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Chianti
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Chianti)
   =>
   (assert (attribute (name best-style) (value "Pilseners & Pale Lager") (certainty 10)))
   (assert (attribute (name best-style) (value "Dark Lager") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-wine-is-Port
   (declare (salience ?*medium-low-priority*))
   (preferred-wine Port)
   =>
   (assert (attribute (name best-name) (value "Barrel-Aged Beer") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-clean
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor clean)
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-sweet
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor sweet)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-sweet-flavor-is-toasty
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-sweet-flavor toasty)
   =>
   (assert (attribute (name best-name) (value "English-Style Mild") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Schwarzbier") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Dunkelweizen") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Brown Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Bock") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-sweet-flavor-is-caramelly
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-sweet-flavor caramelly)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 20)))
   (assert (attribute (name best-name) (value "Scottish-Style Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Irish-Style Red") (certainty 20)))
   (assert (attribute (name best-name) (value "French-Style Biére de Garde") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 20)))
   (assert (attribute (name best-name) (value "Scotch Ale/Wee Heavy") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-roasty
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor roasty)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-roasty-flavor-is-malty
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-roasty-flavor malty)
   =>
   (assert (attribute (name best-name) (value "German-Style Schwarzbier") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 20)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Oatmeal Stout") (certainty 20)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "English-Style Brown Ale") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-roasty-flavor-is-dry
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-roasty-flavor dry)
   =>
   (assert (attribute (name best-name) (value "Irish-Style Dry Stout") (certainty 20)))
   (assert (attribute (name best-name) (value "American Black Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American Stout") (certainty 20)))
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-bitter
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor bitter)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-bitter-flavor-is-earthy
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-bitter-flavor earthy)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 20)))
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American IPA") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-bitter-flavor-is-malt-forward
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-bitter-flavor malt-forward)
   =>
   (assert (attribute (name best-name) (value "California Common") (certainty 20)))
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American Barley Wine") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-bitter-flavor-is-strong-hop
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-bitter-flavor strong-hop)
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Imperial IPA") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-fruity
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor fruity)
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-fruity-or-spicy-flavor-is-brighter
   (declare (salience ?*medium-low-priority*))
   (or (preferred-aroma-for-fruity-flavor brighter)
       (preferred-aroma-for-spicy-flavor brighter))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Witbier") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Hefeweizen") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-fruity-or-spicy-flavor-is-darker
   (declare (salience ?*medium-low-priority*))
   (or (preferred-aroma-for-fruity-flavor darker)
       (preferred-aroma-for-spicy-flavor darker))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Quadrupel") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-sour-flavor-is-light
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-sour-flavor light)
   =>
   (assert (attribute (name best-name) (value "Berliner-Style Weisse") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-sour-flavor-is-medium
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-sour-flavor medium)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 20)))
   (assert (attribute (name best-name) (value "American Brett") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-aroma-for-sour-flavor-is-strong
   (declare (salience ?*medium-low-priority*))
   (preferred-aroma-for-sour-flavor strong)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 20)))
   (assert (attribute (name best-name) (value "American Brett") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 20))))

; determine best beer attributes for meal type recognized

(defrule determine-best-beer-attributes-if-main-meal-is-grain
   (declare (salience ?*medium-low-priority*))
   (or (main-meal-omnivorous grain)
       (main-meal-vegetarian grain)
       (main-meal-vegan grain))
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 40))))

(defrule determine-best-beer-attributes-if-main-meal-is-legumes
   (declare (salience ?*medium-low-priority*))
   (or (main-meal-omnivorous legumes)
       (main-meal-vegetarian legumes)
       (main-meal-vegan legumes))
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 40))))

(defrule determine-best-beer-attributes-if-main-meal-is-fats
   (declare (salience ?*medium-low-priority*))
   (or (main-meal-omnivorous fats)
       (main-meal-vegetarian "vegetable fats")
       (main-meal-vegan "vegetable fats"))
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 80)))
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 40))))

(defrule determine-best-beer-attributes-if-which-fish-is-shellfish
   (declare (salience ?*medium-low-priority*))
   (which-fish shellfish)
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 40))))

(defrule determine-best-beer-attributes-if-which-vegetables-is-root
   (declare (salience ?*medium-low-priority*))
   (which-vegetables root)
   =>
   (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 70))))

(defrule determine-best-beer-attributes-if-which-vegetables-is-grilled
   (declare (salience ?*medium-low-priority*))
   (which-vegetables grilled)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 70))))

(defrule determine-best-beer-attributes-if-which-meat-is-rich-meats
   (declare (salience ?*medium-low-priority*))
   (which-meat "rich meats")
   =>
   (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 70))))

(defrule determine-best-beer-attributes-if-which-meat-is-game-birds
   (declare (salience ?*medium-low-priority*))
   (which-meat "game birds")
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 70))))

(defrule determine-best-beer-attributes-if-which-meat-is-braised-meats
   (declare (salience ?*medium-low-priority*))
   (which-meat "braised meats")
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 70)))
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 70))))

(defrule determine-best-beer-attributes-if-which-meat-is-pork
   (declare (salience ?*medium-low-priority*))
   (which-meat pork)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 70)))
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 70))))

(defrule determine-best-beer-attributes-if-which-pork-is-prosciutto
   (declare (salience ?*medium-low-priority*))
   (which-pork prosciutto)
   =>
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-pork-is-speck
   (declare (salience ?*medium-low-priority*))
   (which-pork speck)
   =>
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 90)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-pork-is-mortadella
   (declare (salience ?*medium-low-priority*))
   (which-pork mortadella)
   =>
   (assert (attribute (name best-name) (value "German-Style Märzen/Oktoberfest") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-sausage-is-capocollo
   (declare (salience ?*medium-low-priority*))
   (which-sausage capocollo)
   =>
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-sausage-is-soppressata
   (declare (salience ?*medium-low-priority*))
   (which-sausage soppressata)
   =>
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-sausage-is-salame-piccante
   (declare (salience ?*medium-low-priority*))
   (which-sausage "salame piccante")
   =>
   (assert (attribute (name best-name) (value "Imperial IPA") (certainty 90)))
   (assert (attribute (name best-name) (value "Rye Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-is-fresh
   (declare (salience ?*medium-low-priority*))
   (which-cheese fresh)
   =>
   (assert (attribute (name best-style) (value "Wheat Beer") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-is-semi-soft
   (declare (salience ?*medium-low-priority*))
   (which-cheese semi-soft)
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 90)))
   (assert (attribute (name best-style) (value "Bock") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Kölsch") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-is-firm/hard
   (declare (salience ?*medium-low-priority*))
   (which-cheese firm/hard)
   =>
   (assert (attribute (name best-style) (value "Bock") (certainty 90)))
   (assert (attribute (name best-style) (value "Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-is-blue
   (declare (salience ?*medium-low-priority*))
   (which-cheese blue)
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-is-natural-rind
   (declare (salience ?*medium-low-priority*))
   (which-cheese "natural rind")
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "American Barley Wine") (certainty 90)))
   (assert (attribute (name best-name) (value "British-Style Barley Wine Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-is-washed-rind
   (declare (salience ?*medium-low-priority*))
   (which-cheese "washed rind")
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fats-is-vegetable
   (declare (salience ?*medium-low-priority*))
   (or (which-fats vegetable)
       (main-meal-vegetarian "vegetables fats")
       (main-meal-vegan "vegetables fats"))
   =>
   (assert (attribute (name best-carbonation) (value high) (certainty 80)))
   (assert (attribute (name best-carbonation) (value medium) (certainty 40))))

(defrule determine-best-beer-attributes-if-which-chocolate-is-white
   (declare (salience ?*medium-low-priority*))
   (which-chocolate white)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Witbier") (certainty 90)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-chocolate-is-milk
   (declare (salience ?*medium-low-priority*))
   (which-chocolate milk)
   =>
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 90)))
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-chocolate-is-semisweet
   (declare (salience ?*medium-low-priority*))
   (which-chocolate semisweet)
   =>
   (assert (attribute (name best-name) (value "American Stout") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 90)))
   (assert (attribute (name best-name) (value "American IPA") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-chocolate-is-bittersweet
   (declare (salience ?*medium-low-priority*))
   (which-chocolate bittersweet)
   =>
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Quadrupel") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-chocolate-is-unsweetened/bitter-or-main-meal-vegan-is-chocolate
   (declare (salience ?*medium-low-priority*))
   (or (which-chocolate unsweetened/bitter)
       (main-meal-vegan chocolate))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "American Sour") (certainty 90))))

(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-sweet
   (declare (salience ?*medium-low-priority*))
   (predominant-dish-taste sweet)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 60))))

(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-acid
   (declare (salience ?*medium-low-priority*))
   (predominant-dish-taste acid)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60))))

(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-spice
   (declare (salience ?*medium-low-priority*))
   (predominant-dish-taste spice)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60)))
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 60))))

(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-umami
   (declare (salience ?*medium-low-priority*))
   (predominant-dish-taste umami)
   =>
   (assert (attribute (name best-carbonation) (value medium) (certainty 30)))
   (assert (attribute (name best-carbonation) (value high) (certainty 60))))

(defrule determine-best-beer-attributes-if-main-meal-is-fats-and-predominant-dish-taste-is-sweet
   (declare (salience ?*medium-low-priority*))
   (or (main-meal-omnivorous fats)
       (main-meal-vegetarian "vegetable fats")
       (main-meal-vegan "vegetable fats"))
   (predominant-dish-taste sweet)
   =>
   (assert (attribute (name best-alcohol) (value harsh) (certainty 30)))
   (assert (attribute (name best-alcohol) (value noticeable) (certainty 15))))

(defrule determine-best-beer-attributes-if-dish-cooking-method-is-dry-heat
   (declare (salience ?*medium-low-priority*))
   (dish-cooking-method dry-heat)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60))))
