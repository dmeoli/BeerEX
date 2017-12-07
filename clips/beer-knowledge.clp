
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

(defrule determine-best-beer-attributes-whether-he-eats-fermented-foods
   (declare (salience ?*medium-low-priority*))
   (fermented-foods-eater yes)
   =>
   (assert (attribute (name best-fermentation) (value wild) (certainty 20))))

(defrule determine-best-beer-attributes-whether-he-is-a-regular-beer-drinker
   (declare (salience ?*medium-low-priority*))
   (driver yes)
   =>
   (assert (attribute (name best-alcohol) (value not-detectable) (certainty 20)))
   (assert (attribute (name best-alcohol) (value mild) (certainty 10))))

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

(defrule determine-best-beer-attributes-if-preferred-flavor-is-roasty
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor roasty)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-bitter
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor bitter)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 20))))

(defrule determine-best-beer-attributes-if-preferred-flavor-is-fruity
   (declare (salience ?*medium-low-priority*))
   (preferred-flavor fruity)
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 20))))

; determine best beer attributes for meal type recognized

(defrule determine-best-beer-attributes-if-which-pizza-topping-is-classic
   (declare (salience ?*medium-low-priority*))
   (or (pizza-topping-for-omnivorous classic)
       (pizza-topping-for-vegetarian classic)
       (pizza-topping-for-vegan classic))
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-pizza-topping-for-omnivorous-is-meat
   (declare (salience ?*medium-low-priority*))
   (meat-topping-is-spicy no)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-pizza-topping-for-omnivorous-is-spicy-meat
   (declare (salience ?*medium-low-priority*))
   (meat-topping-is-spicy yes)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-pizza-topping-are-vegetables
  (declare (salience ?*medium-low-priority*))
  (vegetables-topping-are-roasted no)
  =>
  (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-pizza-topping-are-roasted-vegetables
   (declare (salience ?*medium-low-priority*))
   (vegetables-topping-are-roasted yes)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-pizza-topping-for-omnivorous-or-vegetarian-is-cheese
   (declare (salience ?*medium-low-priority*))
   (or (pizza-topping-for-omnivorous cheese)
       (pizza-topping-for-vegetarian cheese))
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 50))))

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

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Ricotta-or-which-grain-is-bruschetta
   (declare (salience ?*medium-low-priority*))
   (or (which-fresh-cheese Ricotta)
       (which-grain-is-bruschetta))
   =>
   (assert (attribute (name best-name) (value "Honey Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Chevre
   (declare (salience ?*medium-low-priority*))
   (which-fresh-cheese Chèvre)
   =>
   (assert (attribute (name best-name) (value "American Wheat") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Hefeweizen") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "European-Style Export") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-fresh-cheese-is-Feta-or-which-pork-is-loin
   (declare (salience ?*medium-low-priority*))
   (or (which-fresh-cheese Feta)
       (which-pork loin))
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

(defrule determine-best-beer-attributes-if-which-semi-soft-cheese-is-Mozzarella
   (declare (salience ?*medium-low-priority*))
   (which-semi-soft-cheese Mozzarella)
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 50)))
   (assert (attribute (name best-name) (value "American Imperial Red Ale") (certainty 90))))

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

(defrule determine-best-beer-attributes-if-which-semi-soft-cheese-is-Monterey-Jack-or-shellfish-is-mild
   (declare (salience ?*medium-low-priority*))
   (or (which-semi-soft-cheese "Monterey Jack")
       (shellfish-is-mild yes))
   =>
   (assert (attribute (name best-name) (value "American Cream Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-firm-hard
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style firm/hard)
   =>
   (assert (attribute (name best-style) (value "Bock") (certainty 80)))
   (assert (attribute (name best-style) (value "Brown Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 80)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 80)))
   (assert (attribute (name best-name) (value "American Imperial Stout") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-firm-hard-cheese-is-Swiss
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Swiss)
   =>
   (assert (attribute (name best-name) (value "German-Style Maibock") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-firm-hard-cheese-is-Gouda
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Gouda)
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 50)))
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

(defrule determine-best-beer-attributes-if-which-firm-hard-cheese-is-Cheddar
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
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 50)))
   (assert (attribute (name best-name) (value "English-Style IPA") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Oatmeal Stout") (certainty 90))))

(defrule determine-best-beer-attributes-if-Cheddar-is-sharp-or-which-rich-is-grilled-lamb
   (declare (salience ?*medium-low-priority*))
   (or (Cheddar-is-sharp yes)
       (and (meat-cooking-method grilled)
            (which-rich lamb)))
   =>
   (assert (attribute (name best-name) (value "American Stout") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-color-of-Cheddar-is-white-and-which-Cheddar-seasoning-is-mild
   (declare (salience ?*medium-low-priority*))
   (which-color-of-Cheddar white)
   (which-Cheddar-seasoning mild)
   =>
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-type-of-Swiss-is-Emmental-or-which-bluefish-is-grilled-salmon
   (declare (salience ?*medium-low-priority*))
   (or (which-type-of-Swiss Emmental)
       (and (fish-cooking-method grilled)
            (which-bluefish salmon)))
   =>
   (assert (attribute (name best-name) (value "German-Style Brown/Altbier") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-type-of-Swiss-is-Gruyere
   (declare (salience ?*medium-low-priority*))
   (which-type-of-Swiss Gruyère)
   =>
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90))))

(defrule determine-best-beer-attributes-if-Swiss-is-aged
   (declare (salience ?*medium-low-priority*))
   (Swiss-is-aged yes)
   =>
   (assert (attribute (name best-name) (value "German-Style Bock") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-firm-hard-cheese-is-Parmesan
   (declare (salience ?*medium-low-priority*))
   (which-firm/hard-cheese Parmesan)
   =>
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-cheese-style-is-is-blue
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style blue)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 50)))
   (assert (attribute (name best-style) (value "India Pale Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "American Black Ale") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-blue-or-natural-rind-cheese-is-Stilton
   (declare (salience ?*medium-low-priority*))
   (or (which-blue-cheese Stilton)
       (which-natural-rind-cheese Stilton))
   =>
   (assert (attribute (name best-name) (value "British-Style Barley Wine Ale") (certainty 90))))

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
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 50)))
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Camembert
   (declare (salience ?*medium-low-priority*))
   (which-natural-rind-cheese Camembert)
   =>
   (assert (attribute (name best-name) (value "Pumpkin Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-natural-rind-cheese-is-Triple-Creme
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

(defrule determine-best-beer-attributes-if-which-cheese-style-is-washed-rind
   (declare (salience ?*medium-low-priority*))
   (which-cheese-style "washed rind")
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Blonde Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Golden Strong Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 80)))
   (assert (attribute (name best-name) (value "Belgian-Style Dubbel") (certainty 80)))
   (assert (attribute (name best-name) (value "French-Style Biére de Garde") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-washed-rind-cheese-is-Taleggio
   (declare (salience ?*medium-low-priority*))
   (which-washed-rind-cheese Taleggio)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-entree-is-grain
   (declare (salience ?*medium-low-priority*))
   (or (which-entrée-omnivorous grain)
       (which-entrée-vegetarian grain)
       (which-entrée-vegan grain))
   =>
   (assert (attribute (name best-flavor) (value crisp-clean) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-grain-are-chips
   (declare (salience ?*medium-low-priority*))
   (which-grain chips)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Pale Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-grain-is-spaghetti
   (declare (salience ?*medium-low-priority*))
   (which-grain spaghetti)
   =>
   (assert (attribute (name best-name) (value "Blonde Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-grain-are-grits-or-which-shellfish-are-grilled-shrimps
   (declare (salience ?*medium-low-priority*))
   (or (which-grain grits)
       (and (fish-cooking-method grilled)
            (which-shellfish shrimps)))
   =>
   (assert (attribute (name best-name) (value "American Black Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-entree-is-legumes
   (declare (salience ?*medium-low-priority*))
   (or (which-entrée-omnivorous legumes)
       (which-entrée-vegetarian legumes)
       (which-entrée-vegan legumes))
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-which-entree-omnivorous-is-fish
   (declare (salience ?*medium-low-priority*))
   (which-entrée-omnivorous fish)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 80)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-fish-is-shellfish
   (declare (salience ?*medium-low-priority*))
   (which-fish shellfish)
   =>
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 50)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-shellfish-are-mussels
   (declare (salience ?*medium-low-priority*))
   (which-shellfish mussels)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Saison") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Lambic/Gueuze") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-shellfish-are-oysters
   (declare (salience ?*medium-low-priority*))
   (which-shellfish oysters)
   =>
   (assert (attribute (name best-name) (value "Irish-Style Dry Stout") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-which-entree-omnivorous-is-meat
   (declare (salience ?*medium-low-priority*))
   (which-entrée-omnivorous meat)
   =>
   (assert (attribute (name best-name) (value "Scotch Ale/Wee Heavy") (certainty 80)))
   (assert (attribute (name best-name) (value "Scottish-Style Ale") (certainty 80))))

(defrule determine-best-beer-attributes-if-meat-cooking-method-is-barbecue
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method barbecue)
   =>
   (assert (attribute (name best-name) (value "American Amber Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-meat-cooking-method-is-braised-or-which-dessert-is-chocolate
   (declare (salience ?*medium-low-priority*))
   (or (meat-cooking-method braised)
       (which-dessert chocolate))
   =>
   (assert (attribute (name best-flavor) (value malty-sweet) (certainty 50)))
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 50))))

(defrule determine-best-beer-attributes-if-meat-cooking-method-is-grilled
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method grilled)
   =>
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 90)))
   (assert (attribute (name best-name) (value "Vienna-Style Lager") (certainty 90)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90))))

(defrule determine-best-beer-attributes-if-meat-cooking-method-is-roasted
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method roasted)
   =>
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Brown Porter") (certainty 90)))
   (assert (attribute (name best-name) (value "Robust Porter") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-meat-is-rich-meats
   (declare (salience ?*medium-low-priority*))
   (which-meat rich)
   =>
   (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-rich-is-roasted-beef-or-which-rich-is-lamb
   (declare (salience ?*medium-low-priority*))
   (or (and (meat-cooking-method roasted)
            (which-rich beef))
       (which-rich lamb))
   =>
   (assert (attribute (name best-name) (value "English-Style Old Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-beef-is-bresola
   (declare (salience ?*medium-low-priority*))
   (which-beef bresola)
   =>
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Rye Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-rich-is-roasted-lamb
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method roasted)
   (which-rich lamb)
   =>
   (assert (attribute (name best-name) (value "French-Style Biére de Garde") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-rich-is-pork
   (declare (salience ?*medium-low-priority*))
   (which-rich pork)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 50)))
   (assert (attribute (name best-flavor) (value fruity-spicy) (certainty 50)))
   (assert (attribute (name best-name) (value "German-Style Doppelbock") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-rich-is-roasted-pork-or-which-meat-is-steak
   (declare (salience ?*medium-low-priority*))
   (or (and (meat-cooking-method roasted)
            (which-rich pork))
       (which-meat steak))
   =>
   (assert (attribute (name best-name) (value "English-Style Brown Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-pork-is-tenderloin
   (declare (salience ?*medium-low-priority*))
   (which-pork tenderloin)
   =>
   (assert (attribute (name best-name) (value "Coffee Beer") (certainty 90))))

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
   (assert (attribute (name best-name) (value "American Pale Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-pork-is-mortadella
   (declare (salience ?*medium-low-priority*))
   (which-pork mortadella)
   =>
   (assert (attribute (name best-name) (value "German-Style Märzen/Oktoberfest") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-pork-is-sausage
   (declare (salience ?*medium-low-priority*))
   (which-pork sausage)
   =>
   (assert (attribute (name best-name) (value "German-Style Dunkel") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-pork-is-grilled-sausage
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method grilled)
   (which-pork sausage)
   =>
   (assert (attribute (name best-name) (value "Smoke Porter") (certainty 90))))

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

(defrule determine-best-beer-attributes-if-which-poultry-is-chicken
   (declare (salience ?*medium-low-priority*))
   (which-poultry chicken)
   =>
   (assert (attribute (name best-name) (value "German-Style Weizenbock") (certainty 90)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-poultry-is-roasted-chicken
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method roasted)
   (which-poultry chicken)
   =>
   (assert (attribute (name best-name) (value "English-Style Bitter") (certainty 90)))
   (assert (attribute (name best-name) (value "English-Style Pale Ale (ESB)") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Dunkelweizen") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-poultry-is-roasted-turkey
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method roasted)
   (which-poultry turkey)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Tripel") (certainty 90)))
   (assert (attribute (name best-name) (value "Pumpkin Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-meat-is-game
   (declare (salience ?*medium-low-priority*))
   (which-meat game)
   =>
   (assert (attribute (name best-name) (value "Scotch Ale/Wee Heavy") (certainty 90)))
   (assert (attribute (name best-name) (value "Scottish-Style Ale") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-meat-is-grilled-or-roasted-game
   (declare (salience ?*medium-low-priority*))
   (or (meat-cooking-method grilled)
       (meat-cooking-method roasted))
   (which-meat game)
   =>
   (assert (attribute (name best-name) (value "American Brett") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-game-is-wild-or-which-other-vegetables-are-mushrooms
   (declare (salience ?*medium-low-priority*))
   (or (which-game wild)
       (which-other-vegetables mushrooms))
   =>
   (assert (attribute (name best-name) (value "English-Style Mild") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-game-is-birds
   (declare (salience ?*medium-low-priority*))
   (which-game birds)
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-game-birds-is-roasted-duck
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method roasted)
   (which-game-birds duck)
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Quadrupel") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-meat-is-grilled-steak
   (declare (salience ?*medium-low-priority*))
   (meat-cooking-method grilled)
   (which-meat steak)
   =>
   (assert (attribute (name best-name) (value "European-Style Export") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-entree-is-vegetables
   (declare (salience ?*medium-low-priority*))
   (or (which-entrée-omnivorous vegetables)
       (which-entrée-vegetarian vegetables)
       (which-entrée-vegan vegetables))
   =>
   (assert (attribute (name best-name) (value "American Amber Lager") (certainty 80)))
   (assert (attribute (name best-name) (value "Vienna-Style Lager") (certainty 80)))
   (assert (attribute (name best-name) (value "American Brown Ale") (certainty 80))))

(defrule determine-best-beer-attributes-if-which-vegetables-is-root
   (declare (salience ?*medium-low-priority*))
   (which-vegetables root)
   =>
   (assert (attribute (name best-flavor) (value sour-tart-funky) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-vegetables-is-salad
   (declare (salience ?*medium-low-priority*))
   (which-vegetables salad)
   =>
   (assert (attribute (name best-name) (value "American Wheat") (certainty 90)))
   (assert (attribute (name best-name) (value "American Cream Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "Bohemian-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "German-Style Pilsener") (certainty 90)))
   (assert (attribute (name best-name) (value "Fruit and Field Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-vegetables-cooking-method-is-grilled
   (declare (salience ?*medium-low-priority*))
   (vegetables-cooking-method grilled)
   =>
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 50)))
   (assert (attribute (name best-name) (value "Smoke Beer") (certainty 90))))

(defrule determine-best-beer-attributes-if-vegetables-cooking-method-is-roasted
   (declare (salience ?*medium-low-priority*))
   (vegetables-cooking-method roasted)
   =>
   (assert (attribute (name best-name) (value "German-Style Dunkel") (certainty 90)))
   (assert (attribute (name best-name) (value "Irish-Style Red") (certainty 90))))

(defrule determine-best-beer-attributes-if-which-entree-is-fats
   (declare (salience ?*medium-low-priority*))
   (or (which-entrée-omnivorous fats)
       (which-entrée-vegetarian "vegetable fats")
       (which-entrée-vegan "vegetable fats"))
   =>
   (assert (attribute (name best-flavor) (value hoppy-bitter) (certainty 50)))
   (assert (attribute (name best-flavor) (value dark-roasty) (certainty 50))))

(defrule determine-best-beer-attributes-if-which-fats-is-vegetable
   (declare (salience ?*medium-low-priority*))
   (or (which-fats vegetable)
       (which-entrée-vegetarian "vegetables fats")
       (which-entrée-vegan "vegetables fats"))
   =>
   (assert (attribute (name best-carbonation) (value high) (certainty 50)))
   (assert (attribute (name best-carbonation) (value medium) (certainty 25))))

(defrule determine-best-beer-attributes-if-creamy-dessert-is-fruit
   (declare (salience ?*medium-low-priority*))
   (creamy-dessert-with-fruit yes)
   =>
   (assert (attribute (name best-name) (value "Scotch Ale/Wee Heavy") (certainty 90)))
   (assert (attribute (name best-name) (value "Scottish-Style Ale") (certainty 90)))
   (assert (attribute (name best-name) (value "American Sour") (certainty 90))))

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

(defrule determine-best-beer-attributes-if-which-chocolate-is-unsweetened-bitter
   (declare (salience ?*medium-low-priority*))
   (or (which-chocolate unsweetened/bitter)
       (main-meal-for-vegan "unsweetened/bitter chocolate"))
   =>
   (assert (attribute (name best-name) (value "Belgian-Style Flanders") (certainty 90)))
   (assert (attribute (name best-name) (value "Belgian-Style Fruit Lambic") (certainty 90)))
   (assert (attribute (name best-name) (value "American Sour") (certainty 90))))
