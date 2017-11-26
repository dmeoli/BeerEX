
;;************************
;;* BEER KNOWLEDGE RULES *
;;************************

; determine best beer attributes for user type and scenario recognized

(defrule determine-best-beer-attributes-if-preferred-carbonation-is-any
   (declare (salience ?*medium-low-priority*))
   (preferred-carbonation ?carbonation)
   =>
   (assert (attribute (name best-carbonation) (value ?carbonation) (certainty 20))))

(defrule determine-best-beer-attributes-if-regular-beer-drinker-is-no
   (declare (salience ?*medium-low-priority*))
   (regular-beer-drinker no)
   =>
   (assert (attribute (name best-name) (value "American Cream Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "Blonde Ale") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Helles") (certainty 20)))
   (assert (attribute (name best-name) (value "German-Style Kölsch") (certainty 20)))
   (assert (attribute (name best-name) (value "Belgian-Style Witbier") (certainty 10)))
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "Irish-Style Red") (certainty 10)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 10)))
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 10))))

(defrule determine-best-beer-attributes-if-preferred-color-is-any
   (declare (salience ?*medium-low-priority*))
   (preferred-color ?color)
   =>
   (assert (attribute (name best-color) (value ?color) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-fermentation-is-any
   (declare (salience ?*medium-low-priority*))
   (preferred-fermentation ?fermentation)
   =>
   (assert (attribute (name best-fermentation) (value ?fermentation) (certainty 20))))

(defrule determine-best-beer-attributes-if-fermented-foods-eater-is-yes
   (declare (salience ?*medium-low-priority*))
   (fermented-foods-eater yes)
   =>
   (assert (attribute (name best-fermentation) (value wild) (certainty 20))))

(defrule determine-best-beer-attributes-if-driver-is-yes
   (declare (salience ?*medium-low-priority*))
   (driver yes)
   =>
   (assert (attribute (name best-alcohol) (value not-detectable) (certainty 20)))
   (assert (attribute (name best-alcohol) (value mild) (certainty 10))))

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

(defrule determine-best-beer-attributes-if-which-cigar-is-claro
   (declare (salience ?*medium-low-priority*))
   (which-cigar claro)
   =>
   (assert (attribute (name best-style) (value "Wheat Beer") (certainty 20))))

(defrule determine-best-beer-attributes-if-which-cigar-is-maduro
   (declare (salience ?*medium-low-priority*))
   (which-cigar maduro)
   =>
   (assert (attribute (name best-style) (value "Stout") (certainty 20)))
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 20))))

(defrule determine-best-beer-attributes-if-which-cigar-is-oscuro
   (declare (salience ?*medium-low-priority*))
   (which-cigar oscuro)
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 20))))

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

; determine best beer attributes for meal type recognized...

   ; ... if main meal is cheese

(defrule determine-best-beer-attributes-if-which-cheese-style-is-fresh
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style fresh)
   =>
   (assert (attribute (name best-style) (value "Wheat Beer") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Mascarpone
   (declare (salience ?*medium-low-priority*))
   (which-fresh-cheese Mascarpone)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Witbier") (certainty 90))))

(defrule determine-best-beer-attributes-if-Mascarpone-with-fruit-is-yes
   (declare (salience ?*medium-low-priority*))
   (mascarpone-with-fruit yes)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Ricotta
   (declare (salience ?*medium-low-priority*))
   (which-fresh-cheese Ricotta)
   =>
   (assert (attribute (name best-name) (value "Honey Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Chèvre
   (declare (salience ?*medium-low-priority*))
   (which-fresh-cheese Chèvre)
   =>
   (assert (attribute (name best-name) (value "American Wheat") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Hefeweizen") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "European-Style Export") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Feta
   (declare (salience ?*medium-low-priority*))
   (which-fresh-cheese Feta)
   =>
   (assert (attribute (name best-name) (value "California Common") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Cream-Cheese
   (declare (salience ?*medium-low-priority*))
   (which-fresh-cheese "Cream Cheese")
   =>
   (assert (attribute (name best-name) (value "Fruit and Field Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-semi-soft
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style semi-soft)
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "German-Style Bock") (certainty 80)))
   (assert (attribute (name best-name) (value "German-Style Kölsch") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-semi-soft-cheese-is-Colby
   (declare (salience ?*medium-low-priority*))
   (which-semi-soft-cheese Colby)
   =>
   (assert (attribute (name best-name) (value "German-Style Helles") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-semi-soft-cheese-is-Havarti
   (declare (salience ?*medium-low-priority*))
   (which-semi-soft-cheese Havarti)
   =>
   (assert (attribute (name best-name) (value "Berliner-Style Weisse") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-semi-soft-cheese-is-Monterey-Jack
   (declare (salience ?*medium-low-priority*))
   (which-semi-soft-cheese "Monterey Jack")
   =>
   (assert (attribute (name best-name) (value "American Cream Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-firm/hard
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style firm/hard)
   =>
   (assert (attribute (name best-style) (value "Bock") (certainty 80)))
   (assert (attribute (name best-style) (value "Brown Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 80)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 80)))
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-firm/hard-cheese-is-Gouda
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Gouda)
   =>
   (assert (attribute (name best-name) (value "German-Style Dunkelweizen") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-type-of-Gouda-is-aged
   (declare (salience ?*medium-low-priority*))
   (which-type-of-Gouda aged)
   =>
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Quadrupel") (certainty 90)))
   (assert (attribute (name best-name) (value "Baltic-Style Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "American Black Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-type-of-Gouda-is-smoked
   (declare (salience ?*medium-low-priority*))
   (which-type-of-Gouda smoked)
   =>
   (assert (attribute (name best-name) (value "American Imperial Porter") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-firm/hard-cheese-is-Cheddar
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Cheddar)
   =>
   (assert (attribute (name best-name) (value "Irish-Style Red") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-color-of-Cheddar-is-white
   (declare (salience ?*medium-low-priority*))
   (which-color-of-Cheddar white)
   =>
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-Cheddar-seasoning-is-mild
   (declare (salience ?*medium-low-priority*))
   (which-Cheddar-seasoning mild)
   =>
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Mild") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-Cheddar-seasoning-is-medium
   (declare (salience ?*medium-low-priority*))
   (which-Cheddar-seasoning medium)
   =>
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-Cheddar-seasoning-is-aged
   (declare (salience ?*medium-low-priority*))
   (which-Cheddar-seasoning aged)
   =>
   (assert (attribute (name best-name) (value "English-Style IPA") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Oatmeal Stout") (certainty 90))))

(defrule determine-best-beer-attributes-if-Cheddar-is-sharp
   (declare (salience ?*medium-low-priority*))
   (Cheddar-is-sharp yes)
   =>
   (assert (attribute (name best-name) (value "American Stout") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-color-of-Cheddar-is-white-and-which-Cheddar-seasoning-is-mild
   (declare (salience ?*medium-low-priority*))
   (which-color-of-Cheddar white)
   (which-Cheddar-seasoning mild)
   =>
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-firm/hard-cheese-is-Emmental
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Emmental)
   =>
   (assert (attribute (name best-name) (value "German-Style Brown/Altbier") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-firm/hard-cheese-is-Gruyère
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Gruyère)
   =>
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-firm/hard-cheese-is-Parmesan
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Parmesan)
   =>
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-is-blue
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style blue)
   =>
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "American Black Ale") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-natural-rind
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style "natural rind")
   =>
   (assert (attribute (name best-style) (value "Pale Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Blonde Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "American Barley Wine") (certainty 80)))
   (assert (attribute (name best-name) (value "British-Style Barley Wine Ale") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Brie
   (declare (salience ?*medium-low-priority*))
   (which-natural-rind-cheese Brie)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Camembert
   (declare (salience ?*medium-low-priority*))
   (which-natural-rind-cheese Camembert)
   =>
   (assert (attribute (name best-name) (value "Pumpkin Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Triple-Crème
   (declare (salience ?*medium-low-priority*))
   (which-natural-rind-cheese "Triple Crème")
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Mimolette
   (declare (salience ?*medium-low-priority*))
   (which-natural-rind-cheese Mimolette)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Stilton
   (declare (salience ?*medium-low-priority*))
   (which-natural-rind-cheese Stilton)
   =>
   (assert (attribute (name best-name) (value "British-Style Barley Wine Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-washed-rind
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style "washed rind")
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-washed-rind-cheese-is-Taleggio
   (declare (salience ?*medium-low-priority*))
   (which-washed-rind-cheese Taleggio)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 90))))

   ; ... if main meal is entree

(defrule determine-best-beer-attributes-if-which-entree-is-grain
   (declare (salience ?*medium-low-priority*))
   (or (which-entree-omnivorous grain)
       (which-entree-vegetarian grain)
       (which-entree-vegan grain))
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 40))))

(defrule determine-best-beer-attributes-if-which-entree-is-legumes
   (declare (salience ?*medium-low-priority*))
   (or (which-entree-omnivorous legumes)
       (which-entree-vegetarian legumes)
       (which-entree-vegan legumes))
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 40))))

(defrule determine-best-beer-attributes-if-which-entree-is-fats
   (declare (salience ?*medium-low-priority*))
   (or (which-entree-omnivorous fats)
       (which-entree-vegetarian "vegetable fats")
       (which-entree-vegan "vegetable fats"))
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

(defrule determine-best-beer-attributes-if-which-fats-is-vegetable
   (declare (salience ?*medium-low-priority*))
   (or (which-fats vegetable)
       (which-entree-vegetarian "vegetables fats")
       (which-entree-vegan "vegetables fats"))
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

(defrule determine-best-beer-attributes-if-which-chocolate-is-unsweetened/bitter-or-which-entree-vegan-is-chocolate
   (declare (salience ?*medium-low-priority*))
   (or (which-chocolate unsweetened/bitter)
       (which-entree-vegan chocolate))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "American Sour") (certainty 90))))



;(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-sweet
;   (declare (salience ?*medium-low-priority*))
;   (predominant-dish-taste sweet)
;   =>
;   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 60))))

;(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-acid
;   (declare (salience ?*medium-low-priority*))
;   (predominant-dish-taste acid)
;   =>
;   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60))))

;(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-spice
;   (declare (salience ?*medium-low-priority*))
;   (predominant-dish-taste spice)
;   =>
;   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60)))
;   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 60))))

;(defrule determine-best-beer-attributes-if-predominant-dish-taste-is-umami
;   (declare (salience ?*medium-low-priority*))
;   (predominant-dish-taste umami)
;   =>
;   (assert (attribute (name best-carbonation) (value medium) (certainty 30)))
;   (assert (attribute (name best-carbonation) (value high) (certainty 60))))

;(defrule determine-best-beer-attributes-if-which-entree-is-fats-and-predominant-dish-taste-is-sweet
;   (declare (salience ?*medium-low-priority*))
;   (or (which-entree-omnivorous fats)
;       (which-entree-vegetarian "vegetable fats")
;       (which-entree-vegan "vegetable fats"))
;   (predominant-dish-taste sweet)
;   =>
;   (assert (attribute (name best-alcohol) (value harsh) (certainty 30)))
;   (assert (attribute (name best-alcohol) (value noticeable) (certainty 15))))

;(defrule determine-best-beer-attributes-if-dish-cooking-method-is-dry-heat
;   (declare (salience ?*medium-low-priority*))
;   (dish-cooking-method dry-heat)
;   =>
;   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 60))))
