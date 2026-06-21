;;;===========================================================================
;;; labels-it.clp - Optional Italian overlay (gettext-style)
;;;
;;;   English is the base language and the lookup key; these facts provide the
;;;   Italian text. Anything not listed here falls back to English. Loaded after
;;;   clips/beerex.clp (which defines the `translation` template). Activate with
;;;   (bind ?*lang* it)  (the bot exposes /it and /en).
;;;
;;;   This is a starter catalogue: the result chrome and the scenario/preference
;;;   questions. Extend it freely with the meal questions, helps and explanations.
;;;
;;;   Author: Donato Meoli
;;;===========================================================================

(deffacts italian-labels
   ; --- result chrome ---
   (translation (en "*✅ Done. I have selected these beer styles for you...*")
                (it "*✅ Fatto. Ho selezionato per te questi stili di birra...*"))
   (translation (en "*🚫 Sorry! I could not select any beer style for you. 😞")
                (it "*🚫 Spiacente! Non sono riuscito a selezionare alcuno stile per te. 😞"))
   (translation (en "Please, try again! 💪🏻*")
                (it "Riprova! 💪🏻*"))
   (translation (en "*... for the following reasons:*")
                (it "*... per i seguenti motivi:*"))
   (translation (en "*🔎 Why these beers:*")
                (it "*🔎 Perché queste birre:*"))

   ; --- scenario questions (display) ---
   (translation (en "How old are you? 🔞")
                (it "Quanti anni hai? 🔞"))
   (translation (en "Are you a regular beer drinker? 🍺")
                (it "Bevi birra abitualmente? 🍺"))
   (translation (en "Do you usually smoke while drinking? 🚬")
                (it "Di solito fumi mentre bevi? 🚬"))
   (translation (en "Is it autumn, spring, summer or winter? 🍁🌱🏖❄️")
                (it "È autunno, primavera, estate o inverno? 🍁🌱🏖❄️"))

   ; --- preference questions (display) ---
   (translation (en "Do you generally prefer pale, amber, brown or dark beer? 🍺")
                (it "In genere preferisci una birra chiara, ambrata, bruna o scura? 🍺"))
   (translation (en "Do you generally prefer to drink low, mild, high or very high alcoholic drinks? 🍹")
                (it "In genere preferisci bevande poco, mediamente, molto o fortemente alcoliche? 🍹"))
   (translation (en "Do you generally prefer to drink low, medium or high carbonated drinks? 🍾")
                (it "In genere preferisci bevande poco, mediamente o molto gasate? 🍾"))
   (translation (en "What kind of flavor do you generally prefer?")
                (it "Che tipo di gusto preferisci in genere?"))

   ; --- scenario questions (why) ---
   (translation (en "Younger people tend to prefer less intense beers.")
                (it "Le persone più giovani tendono a preferire birre meno intense."))
   (translation (en "Better start with more standard beers. On the other hand, you may be surprised!")
                (it "Meglio iniziare con birre più standard. D'altra parte, potresti sorprenderti!"))
   (translation (en "Beer may alter the taste of tobacco. Also, stronger beers pair well with tobacco flavor.")
                (it "La birra può alterare il sapore del tabacco. Inoltre, le birre più forti si sposano bene con il tabacco."))
   (translation (en "Weather conditions influence our perceptions and needs. The choice of a beer is among these.")
                (it "Le condizioni meteo influenzano percezioni e bisogni. La scelta della birra è tra questi.")))

;; Meal questions (displays). English keys must match the runtime strings exactly.
(deffacts italian-meal-labels
   (translation (en "Is the main meal pizza, entrée, cheese or dessert?")
                (it "Il piatto principale è pizza, entrée, formaggio o dessert?"))
   (translation (en "Is the pizza topping classic, meat, vegetables, cheese or other? 🍕🥓🍆🧀")
                (it "Il condimento della pizza è classico, carne, verdure, formaggio o altro? 🍕🥓🍆🧀"))
   (translation (en "Is the meat spicy? 🌶")
                (it "La carne è piccante? 🌶"))
   (translation (en "Are the vegetables roasted?")
                (it "Le verdure sono arrostite?"))
   (translation (en "Is the main component of the entrée grain (farro, arborio, wild rice, polenta, etc.), legumes (lentils, fava, chickpea, green beans, etc.), fish, meat, vegetables, fats or other?")
                (it "Il componente principale dell'entrée è cereali (farro, arborio, riso selvatico, polenta, ecc.), legumi (lenticchie, fave, ceci, fagiolini, ecc.), pesce, carne, verdure, grassi o altro?"))
   (translation (en "Is the shellfish mild (squid, cuttlefish, octopus, etc.)? 🐙🦑")
                (it "Il mollusco è delicato (calamaro, seppia, polpo, ecc.)? 🐙🦑"))
   (translation (en "Is the meat rich (beef, lamb, pork, etc.), poultry, game or other? 🍖🥩🦆")
                (it "La carne è rossa (manzo, agnello, maiale, ecc.), pollame, selvaggina o altro? 🍖🥩🦆"))
   (translation (en "Is the rich meat beef, lamb, pork or other?")
                (it "La carne rossa è manzo, agnello, maiale o altro?"))
   (translation (en "Is the beef bresaola or other?")
                (it "Il manzo è bresaola o altro?"))
   (translation (en "Is the sausage capocollo, soppressata, salame piccante or other?")
                (it "La salsiccia è capocollo, soppressata, salame piccante o altro?"))
   (translation (en "Is the game wild or birds (duck, quail, quinoa, etc.)?")
                (it "La selvaggina è di terra o da penna (anatra, quaglia, ecc.)?"))
   (translation (en "Are the vegetables mushrooms or other? 🍄")
                (it "Le verdure sono funghi o altro? 🍄"))
   (translation (en "Is the cheese style fresh (Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese, Quark, Cottage, etc.), semi-soft (Mozzarella, Colby, Fontina, Havarti, Monterey Jack, etc.), firm/hard (Gouda, Cheddar, Swiss, Parmesan, etc.), blue (Roquefort, Gorgonzola, Danish, etc.), natural rind (Brie, Camembert, Triple Crème, Mimolette, Stilton, Lancashire, Tomme de Savoie, etc.) or washed rind (Epoisses, Livarot, Taleggio, etc.)? 🧀")
                (it "Lo stile del formaggio è fresco (Mascarpone, Ricotta, Chèvre, Feta, Cream Cheese, Quark, Cottage, ecc.), semi-molle (Mozzarella, Colby, Fontina, Havarti, Monterey Jack, ecc.), duro (Gouda, Cheddar, Swiss, Parmigiano, ecc.), erborinato (Roquefort, Gorgonzola, Danish, ecc.), a crosta fiorita (Brie, Camembert, Triple Crème, Mimolette, Stilton, Lancashire, Tomme de Savoie, ecc.) o a crosta lavata (Epoisses, Livarot, Taleggio, ecc.)? 🧀"))
   (translation (en "Is the semi-soft cheese Mozzarella, Colby, Havarti, Monterey Jack or other? 🧀")
                (it "Il formaggio semi-molle è Mozzarella, Colby, Havarti, Monterey Jack o altro? 🧀"))
   (translation (en "Is the firm/hard cheese Gouda, Cheddar, Swiss, Parmesan or other? 🧀")
                (it "Il formaggio duro è Gouda, Cheddar, Swiss, Parmigiano o altro? 🧀"))
   (translation (en "Is the Gouda cheese aged, smoked or other? 🧀")
                (it "Il Gouda è stagionato, affumicato o altro? 🧀"))
   (translation (en "Is the Cheddar cheese seasoning mild, medium, aged or other? 🧀")
                (it "La stagionatura del Cheddar è delicata, media, stagionata o altro? 🧀"))
   (translation (en "Is the Swiss cheese Emmental, Gruyère or other? 🧀")
                (it "Il formaggio svizzero è Emmental, Gruyère o altro? 🧀"))
   (translation (en "Is the blue cheese Stilton or other? 🧀")
                (it "Il formaggio erborinato è Stilton o altro? 🧀"))
   (translation (en "Is the natural rind cheese Brie, Camembert, Triple Crème, Mimolette, Stilton, or other? 🧀")
                (it "Il formaggio a crosta fiorita è Brie, Camembert, Triple Crème, Mimolette, Stilton o altro? 🧀"))
   (translation (en "Is the washed rind cheese Taleggio or other? 🧀")
                (it "Il formaggio a crosta lavata è Taleggio o altro? 🧀"))
   (translation (en "Is the dessert creamy, fruit, chocolate or other? 🍮🥧🍪🍫")
                (it "Il dessert è cremoso, alla frutta, al cioccolato o altro? 🍮🥧🍪🍫"))
   (translation (en "Is the creamy dessert with fruit?")
                (it "Il dessert cremoso è con frutta?"))
   (translation (en "Is the chocolate white, milk (35% cacao ca.), semisweet (55% cacao ca.), bittersweet (70% cacao ca.) or unsweetened/bitter (100% cacao)? 🍫")
                (it "Il cioccolato è bianco, al latte (35% cacao ca.), semidolce (55% cacao ca.), fondente (70% cacao ca.) o amaro/non zuccherato (100% cacao)? 🍫")))

;; Long meal/cheese why & help blocks (exact runtime English keys).
(deffacts italian-why-help-labels
   (translation (en "🍕 _Classic_ topping pizzas pair well with crisp and clean beers. Complementary grain and cheese flavors balance hop character while remaining light on the palate. 
🍕🥓 _Meat_ topping pizzas pair well with hoppy and bitter beers, which stands up to strong flavors and cut through fat to deliver a complex finish. 
🍕🍆 _Vegetables_ topping pizzas pair well with sour beers which increases the perception of savoriness or with beers which contrasts the char of the oven-roasted vegetables. 
🍕🧀 _Cheese_ topping pizzas pair well with fruity and spicy beers, thanks to their high carbonation which works overtime to cleanse the palate from a strong flavor.")
                (it "🍕 La pizza _classica_ si abbina a birre fresche e pulite: i sapori complementari di cereali e formaggio bilanciano il luppolo restando leggeri al palato.
🍕🥓 La pizza con _carne_ si abbina a birre luppolate e amare, che reggono i sapori forti e tagliano il grasso per un finale complesso.
🍕🍆 La pizza con _verdure_ si abbina a birre acide, che aumentano la sapidità, o a birre che contrastano la bruciatura delle verdure al forno.
🍕🧀 La pizza al _formaggio_ si abbina a birre fruttate e speziate, grazie all'alta carbonazione che ripulisce il palato da un sapore intenso."))
   (translation (en "Malty flavors highlight the roasted qualities of the meat, while sweetness works to neutralize capsaicin, the active component in chili peppers.")
                (it "I sapori maltati esaltano le qualità arrostite della carne, mentre la dolcezza neutralizza la capsaicina, il componente attivo del peperoncino."))
   (translation (en "The roasted character of the beer complements the char on oven-roasted vegetables.")
                (it "Il carattere tostato della birra completa la bruciatura delle verdure cotte al forno."))
   (translation (en "🌾 Complementary _grain_ flavors balance hops while remaining light on the palate. 
🌱 _Legumes_ add richness to the beer while balancing salt and acidity. 
🐟🦐 _Fish_ pair well with the bitterness of the English-Style Bitter and the sweetness of the English-Style Pale Ale. 
🥩🍖 _Meat_ pairs well with Scottish-Style Ales. 
🍆🥦 _Vegetables_ pair well with clean Dark Lagers and American Brown Ale. 
🥜 With _fats_ strong flavors, beer balances and allows for a complex finish.")
                (it "🌾 I sapori complementari dei _cereali_ bilanciano il luppolo restando leggeri al palato.
🌱 I _legumi_ aggiungono ricchezza alla birra bilanciando sale e acidità.
🐟🦐 Il _pesce_ si abbina all'amaro della English-Style Bitter e alla dolcezza della English-Style Pale Ale.
🥩🍖 La _carne_ si sposa con le Scottish-Style Ale.
🍆🥦 Le _verdure_ si abbinano a Dark Lager pulite e American Brown Ale.
🥜 Con i sapori forti dei _grassi_, la birra bilancia e consente un finale complesso."))
   (translation (en "Carbonation is an effective tool to cleanse vegetable fats.")
                (it "La carbonazione è uno strumento efficace per ripulire i grassi vegetali."))
   (translation (en "🧀 _Fresh_ cheeses are light cheeses which pair excellently with the softer flavors of Wheat and Lambic beers. 
🧀 _Semi-soft_ cheeses can be paired with many different craft beers, such as German Kölsch or Bock and Pale Ale beers. 
🧀 _Firm/hard_ cheeses are easily paired with an equally broad range of craft beer styles, such as Pilsner, Bock, Brown Ale and Imperial Stout. 
🧀 _Blue_ cheeses are stronger-flavored cheeses which are most successfully balanced with stonger-flavored bolder beers like IPAs or Imperial IPAs. 
🧀 _Natural rind_ cheeses pair well with Golden, Blonde and traditional British-style ales. 
🧀 _Washed rind_ cheeses, while potentially pungent, are often creamy and can be paired with Belgian-styles ales, like Triples and Golden Strong ales with these varieties.")
                (it "🧀 I formaggi _freschi_ sono leggeri e si abbinano benissimo ai sapori più morbidi delle birre di frumento e Lambic.
🧀 I formaggi _semi-molli_ si possono abbinare a molte birre artigianali diverse, come la German Kölsch o le Bock e le Pale Ale.
🧀 I formaggi _duri_ si abbinano facilmente a una gamma altrettanto ampia di stili, come Pilsner, Bock, Brown Ale e Imperial Stout.
🧀 I formaggi _erborinati_ hanno sapori più intensi, bilanciati al meglio da birre più decise come IPA o Imperial IPA.
🧀 I formaggi a _crosta fiorita_ si abbinano bene a Golden, Blonde e tradizionali ale in stile britannico.
🧀 I formaggi a _crosta lavata_, pur potenzialmente pungenti, sono spesso cremosi e si possono abbinare ad ale belghe come Triple e Golden Strong."))
   (translation (en "🧀 Italian-Style Mascarpone, Ricotta and soft Chèvre will match the delicate notes of the beer and neither will overwhelm the palate in the beginning of a meal.")
                (it "🧀 Mascarpone, Ricotta in stile italiano e Chèvre morbido assecondano le note delicate della birra senza sopraffare il palato a inizio pasto."))
   (translation (en "🧀 Fontina, Havarti and milder blue cheeses can be enhanced by the carbonation of Kölsch style ales. The gentle notes of grass in the cheese can be brought out by using the malt of a Bock or the hops of a Pale Ale.")
                (it "🧀 Fontina, Havarti ed erborinati più delicati sono esaltati dalla carbonazione delle ale in stile Kölsch. Le delicate note erbacee del formaggio emergono col malto di una Bock o il luppolo di una Pale Ale."))
   (translation (en "🧀 Cheddar and Swiss cheeses can mimic the Maillard reaction when paired with a beer style, such as a Brown Ale. Roasty stouts can add a creaminess to the firm and hard cheeses on the palate.")
                (it "🧀 Cheddar e Swiss possono imitare la reazione di Maillard se abbinati a uno stile come la Brown Ale. Le stout tostate aggiungono cremosità ai formaggi duri al palato."))
   (translation (en "🧀 Emmentaler-style cheeses can mimic the Maillard reaction when paired with a beer style, such as a Brown Ale.")
                (it "🧀 I formaggi in stile Emmentaler possono imitare la reazione di Maillard se abbinati a uno stile come la Brown Ale."))
   (translation (en "🧀 Stilton cheese can be intensified the sweetness on the palate with a Barley Wine.")
                (it "🧀 Lo Stilton può vedere intensificata la dolcezza al palato con un Barley Wine."))
   (translation (en "🧀 Lancashire, Stilton, Brie and Camembert all share a rich creamy base that can be refreshed with a Golden, Blond or Pale Ale or intensified the sweetness on the palate with a Barley Wine.")
                (it "🧀 Lancashire, Stilton, Brie e Camembert condividono una base cremosa e ricca, rinfrescabile con una Golden, Blonde o Pale Ale, o resa più dolce al palato con un Barley Wine."))
   (translation (en "🧀 Classic Belgian yeast flavors spur a tighter carbonation as well as bring out delicate sweet notes that can cut through the funk of a washed rind cheeses.")
                (it "🧀 I classici sapori del lievito belga favoriscono una carbonazione più fine ed esaltano note dolci delicate che tagliano il «funk» dei formaggi a crosta lavata."))
   (translation (en "🧀 _Fresh_ cheeses have not been aged, or are very slightly cured. These cheeses have a high moisture content and are usually mild and have a very creamy taste and soft texture. 
🧀 _Semi-soft_(www.goo.gl/izu1Bw) cheeses have a smooth, generally, creamy interior with little or no rind. These cheeses are generally high in moisture content and range from very mild in flavor to very pungent. 
🧀 _Firm/hard_(www.goo.gl/yrfoJK) cheeses have a taste profiles range from very mild to sharp and pungent. They generally have a texture profile that ranges from elastic, at room temperature, to the hard cheeses that can be grated. 
🧀 _Blue_(www.goo.gl/9KkNww) cheeses have a distinctive blue/green veining, created when the penicillium roqueforti mold, added during the make process, is exposed to air. This mold provides a distinct flavor to the cheese, which ranges from fairly mild to assertive and pungent. 
🧀 _Natural rind_(www.goo.gl/ys8pkz) cheeses have rinds that are self-formed during the aging process. Generally, no molds or microflora are added, nor is washing used to create the exterior rinds, and those that do exhibit molds and microflora in their rinds get them naturally from the environment. 
🧀 _Washed rind_(www.goo.gl/Kh3BwD) cheeses are surface-ripened by washing the cheese throughout the ripening/aging process with brine, beer, wine, brandy, or a mixture of ingredients, which encourages the growth of bacteria. The exterior rind of washed rind cheeses may vary from bright orange to brown, with flavor and aroma profiles that are quite pungent, yet the interior of these cheeses is most often semi-soft and, sometimes, very creamy.")
                (it "🧀 I formaggi _freschi_ non sono stagionati, o lo sono pochissimo. Hanno un alto contenuto di umidità, sono di solito delicati e hanno gusto molto cremoso e consistenza morbida.
🧀 I formaggi _semi-molli_(www.goo.gl/izu1Bw) hanno un interno liscio, in genere cremoso, con poca o nessuna crosta. Sono generalmente ricchi di umidità e vanno da molto delicati a molto pungenti.
🧀 I formaggi _duri_(www.goo.gl/yrfoJK) hanno profili di gusto che vanno da molto delicati a intensi e pungenti. La consistenza va da elastica, a temperatura ambiente, fino ai formaggi duri da grattugiare.
🧀 I formaggi _erborinati_(www.goo.gl/9KkNww) hanno la caratteristica venatura blu/verde, creata quando la muffa penicillium roqueforti, aggiunta in lavorazione, è esposta all'aria. Dà un sapore distintivo, da abbastanza delicato ad assertivo e pungente.
🧀 I formaggi a _crosta fiorita_(www.goo.gl/ys8pkz) hanno croste che si formano da sole durante la stagionatura. In genere non si aggiungono muffe o microflora, né si usa il lavaggio: quelle presenti arrivano naturalmente dall'ambiente.
🧀 I formaggi a _crosta lavata_(www.goo.gl/Kh3BwD) maturano in superficie lavando il formaggio durante la stagionatura con salamoia, birra, vino, brandy o una miscela, favorendo la crescita di batteri. La crosta va dall'arancione acceso al marrone, con profili pungenti, mentre l'interno è spesso semi-molle e talvolta molto cremoso."))
)

;; Result-explanation sentences (the "for the following reasons" narrative).
(deffacts italian-explanation-labels
   (translation (en "It's a high carbonated beer.")
                (it "È una birra molto gasata."))
   (translation (en "It's a low carbonated beer.")
                (it "È una birra poco gasata."))
   (translation (en "It's a medium carbonated beer.")
                (it "È una birra mediamente gasata."))
   (translation (en "Moreover, game birds pair excellently well with beers which presents medium to high hop bitterness, flavor and aroma in order to cleanse the mouth.")
                (it "Inoltre, la selvaggina da penna si abbina benissimo a birre con amaro, sapore e aroma di luppolo da medi ad alti, per pulire la bocca."))
   (translation (en "Moreover, rich meats comes together with beers that presents pronounced acidity.")
                (it "Inoltre, le carni rosse si accompagnano a birre con acidità pronunciata."))
   (translation (en "That's it because blue cheeses are stronger-flavored cheeses which are most successfully balanced with stronger-flavored bolder beers with a roasty flavor, thanks to the roast of the malt that comes through strong and can produce a delicate bitterness in these beers.")
                (it "Questo perché i formaggi erborinati hanno sapori intensi, bilanciati al meglio da birre più decise dal sapore tostato, grazie alla tostatura del malto che emerge con forza e può produrre un amaro delicato in queste birre."))
   (translation (en "That's it because chocolate pair well with beers with a sweet flavor, thanks to the prevalent sense of maltiness on the palate, and also with beers which presents a roasty flavor, thanks to the roast of the malt that comes through strong and can produce a delicate bitterness in these beers.")
                (it "Questo perché il cioccolato si abbina a birre dal sapore dolce, grazie al prevalente senso di maltato al palato, e anche a birre dal sapore tostato, grazie alla tostatura del malto che emerge con forza e può produrre un amaro delicato in queste birre."))
   (translation (en "That's it because desserts pair particularly well with beers that presents an overwhelmingly malty, rich and dominant sweet malt flavor and aroma and soft and chewy mouthfeel.")
                (it "Questo perché i dessert si abbinano particolarmente bene a birre con sapore e aroma di malto travolgente, ricco e dominante dolce, e una sensazione in bocca morbida e avvolgente."))
   (translation (en "That's it because fats pair generally well with beers with a bitter flavor, because of the bitterness of the hops that pleasantly cleanses the mouth, and also with beers characterized by a roasty flavor, thanks to the roast of the malt that comes through strong and can produce a delicate bitterness in these beers.")
                (it "Questo perché i grassi si abbinano in genere bene a birre dal sapore amaro, per l'amaro del luppolo che pulisce piacevolmente la bocca, e anche a birre caratterizzate da un sapore tostato, grazie alla tostatura del malto che emerge con forza e può produrre un amaro delicato."))
   (translation (en "That's it because firm/hard cheeses are easily paired with beers that typically have an extremely rich malty flavor and aroma with full, sweet malt character. Perception of hop bitterness is medium to high; roasted malt, caramel-like and chocolate-like characters could also be perceived.")
                (it "Questo perché i formaggi duri si abbinano facilmente a birre che tipicamente hanno sapore e aroma di malto estremamente ricco, con carattere maltato pieno e dolce. La percezione dell'amaro del luppolo è da media ad alta; si possono percepire anche note di malto tostato, caramello e cioccolato."))
   (translation (en "That's it because fresh cheeses are light cheeses which pair excellently with naturally and spontaneously fermented beers with important sweetness and sourness characters.")
                (it "Questo perché i formaggi freschi sono formaggi leggeri che si abbinano benissimo a birre a fermentazione naturale e spontanea con importanti caratteri di dolcezza e acidità."))
   (translation (en "That's it because grain pair generally well with beers that have a very delicate impact on the palate and can sometimes produce a feeling of dryness in the mouth, creating an overall delicate outcome.")
                (it "Questo perché i cereali si abbinano in genere bene a birre con un impatto molto delicato al palato, che a volte possono dare una sensazione di secchezza in bocca, creando un risultato complessivamente delicato."))
   (translation (en "That's it because legumes pair generally well with a sweet flavor, thanks to the prevalent sense of maltiness on the palate.")
                (it "Questo perché i legumi si abbinano in genere bene a un sapore dolce, grazie al prevalente senso di maltato al palato."))
   (translation (en "That's it because natural rind cheeses pair well with many different craft beers, best of all beers which presents caramel or toffee malt character, and also medium to high bitterness.")
                (it "Questo perché i formaggi a crosta fiorita si abbinano a molte birre artigianali diverse, soprattutto birre con carattere di malto caramello o toffee, e amaro da medio ad alto."))
   (translation (en "That's it because semi-soft cheeses can be paired with many different craft beers, best of all beers which presents caramel or toasted malt flavor, and also medium to high bitterness.")
                (it "Questo perché i formaggi semi-molli si abbinano a molte birre artigianali diverse, soprattutto birre con sapore di malto caramello o tostato, e amaro da medio ad alto."))
   (translation (en "That's it because washed rind cheeses, while potentially pungent, are often creamy and can be paired with beers that presents caramel or toasted malt aromas, with fruity or spicy characters.")
                (it "Questo perché i formaggi a crosta lavata, pur potenzialmente pungenti, sono spesso cremosi e si abbinano a birre con aromi di malto caramello o tostato, con caratteri fruttati o speziati."))
   (translation (en "You chose a high alcoholic beer.")
                (it "Hai scelto una birra ad alto contenuto alcolico."))
   (translation (en "You chose a low alcoholic beer.")
                (it "Hai scelto una birra a basso contenuto alcolico."))
   (translation (en "You chose a medium alcoholic beer.")
                (it "Hai scelto una birra mediamente alcolica."))
   (translation (en "You chose a very high alcoholic beer.")
                (it "Hai scelto una birra molto alcolica."))
   (translation (en "You desire a beer with a bitter flavor.")
                (it "Desideri una birra dal sapore amaro."))
   (translation (en "You desire a beer with a clean flavor.")
                (it "Desideri una birra dal sapore pulito."))
   (translation (en "You desire a beer with a fruity flavor.")
                (it "Desideri una birra dal sapore fruttato."))
   (translation (en "You desire a beer with a roasty flavor.")
                (it "Desideri una birra dal sapore tostato."))
   (translation (en "You desire a beer with a sour flavor.")
                (it "Desideri una birra dal sapore acido."))
   (translation (en "You desire a beer with a sweet flavor.")
                (it "Desideri una birra dal sapore dolce."))
   (translation (en "You prefer a brown beer.")
                (it "Preferisci una birra bruna."))
   (translation (en "You prefer a dark beer.")
                (it "Preferisci una birra scura."))
   (translation (en "You prefer a pale beer.")
                (it "Preferisci una birra chiara."))
   (translation (en "You prefer an amber beer.")
                (it "Preferisci una birra ambrata."))
   (translation (en "You're eating a classic pizza: the best way to enjoy it is pair that with beers that have a very delicate impact on the palate and can sometimes produce a feeling of dryness in the mouth, creating an overall delicate outcome.")
                (it "Stai mangiando una pizza classica: il modo migliore per gustarla è abbinarla a birre con un impatto molto delicato al palato, che a volte possono dare una sensazione di secchezza in bocca, creando un risultato complessivamente delicato."))
   (translation (en "You're eating a pizza with cheese: the best way to enjoy it is pair that with beers with a spicy flavor, derived from the yeast and dominated by notes of fruit and spice like tart apple, pear, peach, orange, lemon, apricot and clove, pepper, vanilla, coriander, cinnamon, nutmeg, bay leaf.")
                (it "Stai mangiando una pizza al formaggio: il modo migliore per gustarla è abbinarla a birre dal sapore speziato, derivato dal lievito e dominato da note di frutta e spezie come mela acidula, pera, pesca, arancia, limone, albicocca e chiodi di garofano, pepe, vaniglia, coriandolo, cannella, noce moscata, alloro."))
   (translation (en "You're eating a pizza with meat: the best way to enjoy it is pair that with beers with a bitter flavor, because of the bitterness of the hops that pleasantly cleanses the mouth.")
                (it "Stai mangiando una pizza con carne: il modo migliore per gustarla è abbinarla a birre dal sapore amaro, per l'amaro del luppolo che pulisce piacevolmente la bocca."))
   (translation (en "You're eating a pizza with roasted vegetables: the best way to enjoy it is pair that with beers with a roasty flavor, thanks to the roast of the malt that comes through strong and can produce a delicate bitterness in these beers.")
                (it "Stai mangiando una pizza con verdure arrostite: il modo migliore per gustarla è abbinarla a birre dal sapore tostato, grazie alla tostatura del malto che emerge con forza e può produrre un amaro delicato in queste birre."))
   (translation (en "You're eating a pizza with spicy meat: the best way to enjoy it is pair that with beers with a sweet flavor, thanks to the prevalent sense of maltiness on the palate.")
                (it "Stai mangiando una pizza con carne piccante: il modo migliore per gustarla è abbinarla a birre dal sapore dolce, grazie al prevalente senso di maltato al palato."))
   (translation (en "You're eating a pizza with vegetables: the best way to enjoy it is pair that with beers with a sour flavor, because of the pronounced acidity blended on the palate with the addition of fruity aromas.")
                (it "Stai mangiando una pizza con verdure: il modo migliore per gustarla è abbinarla a birre dal sapore acido, per la pronunciata acidità unita al palato con l'aggiunta di aromi fruttati."))
)

;; Atomic fragments: welcome, rationale terms/axes/phrases, bot messages.
(deffacts italian-fragment-labels
   (translation (en "Welcome to the Beer EXpert system 🍻️") (it "Benvenuto nel Beer EXpert system 🍻️"))
   (translation (en "⁉️ All I need is that you answer simple questions by choosing one of the responses that are offered to you.") (it "⁉️ Mi basta che tu risponda a semplici domande scegliendo una delle risposte proposte."))
   (translation (en "To start, please press the /new button 😄") (it "Per iniziare, premi il pulsante /new 😄"))
   (translation (en "color") (it "colore"))
   (translation (en "alcohol") (it "alcol"))
   (translation (en "bitterness") (it "amaro"))
   (translation (en "pale") (it "chiara"))
   (translation (en "amber") (it "ambrata"))
   (translation (en "brown") (it "bruna"))
   (translation (en "dark") (it "scura"))
   (translation (en "not-detectable") (it "non percepibile"))
   (translation (en "mild") (it "lieve"))
   (translation (en "noticeable") (it "percepibile"))
   (translation (en "harsh") (it "forte"))
   (translation (en "low") (it "basso"))
   (translation (en "medium") (it "medio"))
   (translation (en "high") (it "alto"))
   (translation (en "crisp-clean") (it "pulito e fresco"))
   (translation (en "malty-sweet") (it "maltato e dolce"))
   (translation (en "dark-roasty") (it "scuro e tostato"))
   (translation (en "hoppy-bitter") (it "luppolato e amaro"))
   (translation (en "fruity-spicy") (it "fruttato e speziato"))
   (translation (en "sour-tart-funky") (it "acido e aspro"))
   (translation (en "paired with your meal") (it "abbinata al tuo pasto"))
   (translation (en "style suits your meal") (it "lo stile si adatta al tuo pasto"))
   (translation (en "matches its CraftBeer pairing") (it "corrisponde all'abbinamento CraftBeer"))
   (translation (en "general match") (it "corrispondenza generale"))
   (translation (en "with certainty") (it "con certezza"))
   (translation (en "Hello %s! 🤖") (it "Ciao %s! 🤖"))
   (translation (en "Bye! I hope we can talk again some day. 👋🏻") (it "Ciao! Spero potremo riparlarne un giorno. 👋🏻"))
   (translation (en "Unrecognized command. Say what?") (it "Comando non riconosciuto. Come?"))
   (translation (en "Sorry, I didn't get that. Press a button or /new.") (it "Spiacente, non ho capito. Premi un pulsante o /new."))
   (translation (en "Backend set to *%s*. Press /new to start.") (it "Backend impostato su *%s*. Premi /new per iniziare."))
   (translation (en "Language set to *%s*. Press /new to start.") (it "Lingua impostata su *%s*. Premi /new per iniziare."))
)

;; Revised scenario + new dessert explanations (English base updated).
(deffacts italian-scenario-explanation-labels
   (translation (en "A more experienced palate tends to enjoy complex, assertive styles, so I can suggest something bolder and more peculiar.")
                (it "Un palato più esperto tende ad apprezzare stili complessi e decisi, quindi posso suggerirti qualcosa di più audace e particolare."))
   (translation (en "At a younger age the palate is usually eased in with approachable, low-alcohol styles with a clean or lightly fruity flavour, rather than intense or very bitter ones.")
                (it "In giovane età il palato si abitua meglio a stili accessibili e poco alcolici, dal sapore pulito o leggermente fruttato, piuttosto che intensi o molto amari."))
   (translation (en "Autumn is the season of malty amber beers of moderate strength: Marzen and Oktoberfest lagers, spiced pumpkin ales and nutty brown ales.")
                (it "L'autunno è la stagione delle birre ambrate e maltate di media gradazione: Märzen e Oktoberfest, ale speziate alla zucca e brown ale dal carattere nocciolato."))
   (translation (en "Frosty days are perfect for warming, full-bodied beers: strong, dark and malty or roasty, such as stouts, bocks and barley wines.")
                (it "Le giornate gelide sono perfette per birre corpose e riscaldanti: forti, scure e maltate o tostate, come stout, bock e barley wine."))
   (translation (en "Hot days call for light, refreshing and very drinkable beers: low in alcohol, crisp and pale, such as pilsners, wheat beers and session ales.")
                (it "Le giornate calde chiedono birre leggere, dissetanti e molto bevibili: poco alcoliche, fresche e chiare, come pilsner, birre di frumento e session ale."))
   (translation (en "Moreover, creamy desserts pair well with a British-Style Barley Wine, whose sweetness is heightened on the palate.")
                (it "Inoltre, i dessert cremosi si abbinano bene a un British-Style Barley Wine, la cui dolcezza viene esaltata al palato."))
   (translation (en "Moreover, fruit desserts pair well with fruity and spicy beers, such as wheat ales, witbier and sour beers.")
                (it "Inoltre, i dessert alla frutta si abbinano bene a birre fruttate e speziate, come le birre di frumento, le witbier e le birre acide."))
   (translation (en "Since you're not a regular beer drinker, I'll start you on approachable, clean and easy-drinking styles, low in bitterness and alcohol; later you'll be ready for something more peculiar.")
                (it "Dato che non sei un bevitore abituale di birra, parto da stili accessibili, puliti e facili da bere, poco amari e poco alcolici; più avanti sarai pronto per qualcosa di più particolare."))
   (translation (en "Spring calls for fresh, moderately strong beers with a clean or lightly spicy, floral character, such as saisons, Maibocks and pale ales.")
                (it "La primavera chiede birre fresche e di media gradazione, dal carattere pulito o leggermente speziato e floreale, come saison, Maibock e pale ale."))
   (translation (en "That's it because creamy fruit desserts pair particularly well with a Belgian-Style Fruit Lambic or a British-Style Barley Wine Ale.")
                (it "Questo perché i dessert cremosi alla frutta si abbinano particolarmente bene a un Belgian-Style Fruit Lambic o a un British-Style Barley Wine Ale."))
   (translation (en "Tobacco dulls the palate and stands up to bold beers, so robust full-flavoured styles pair best while smoking: roasty, malty and stronger beers such as porters, stouts and smoked beers.")
                (it "Il tabacco attenua il palato e regge birre decise, quindi gli stili robusti e dal sapore pieno si abbinano meglio mentre si fuma: birre tostate, maltate e più forti come porter, stout e birre affumicate."))
   (translation (en "Your age lets me choose from a broad variety of beers, balanced across strength and flavour.")
                (it "La tua età mi permette di scegliere tra un'ampia varietà di birre, equilibrate tra gradazione e sapore."))
)

;; Pruned/updated question displays + revised which-entrée why.
(deffacts italian-pruned-question-labels
   (translation (en "Are the fish shellfish mussels, oysters or other? 🦐🦀🐚")
                (it "I crostacei sono cozze, ostriche o altro? 🦐🦀🐚"))
   (translation (en "Is the Cheddar cheese white or other? 🧀")
                (it "Il Cheddar è bianco o altro? 🧀"))
   (translation (en "Is the fats vegetable (avocados, olive oil, peanut butter, nuts and seeds, etc.) or other? 🥑🍖")
                (it "I grassi sono vegetali (avocado, olio d'oliva, burro d'arachidi, frutta secca e semi, ecc.) o altro? 🥑🍖"))
   (translation (en "Is the fish shellfish (clams, scallops, lobster, crab, etc.) or other? 🐟🦐🦀🦑")
                (it "Il pesce è crostacei/molluschi (vongole, capesante, aragosta, granchio, ecc.) o altro? 🐟🦐🦀🦑"))
   (translation (en "Is the fresh cheese Mascarpone, Chèvre, Feta, Cream Cheese or other? 🧀")
                (it "Il formaggio fresco è Mascarpone, Chèvre, Feta, Cream Cheese o altro? 🧀"))
   (translation (en "Is the meat cooking method braised, grilled, roasted or other?")
                (it "Il metodo di cottura della carne è brasato, alla griglia, arrosto o altro?"))
   (translation (en "Is the pork loin, prosciutto, speck, mortadella, sausage or other?")
                (it "Il maiale è lonza, prosciutto, speck, mortadella, salsiccia o altro?"))
   (translation (en "Is the poultry chicken or other? 🦃")
                (it "Il pollame è pollo o altro? 🦃"))
   (translation (en "Is the vegetables cooking method grilled or other?")
                (it "Il metodo di cottura delle verdure è alla griglia o altro?"))
   (translation (en "Is the vegetables root (parsnips, carrots, etc.) or other? 🥕🥗")
                (it "Le verdure sono radici (pastinaca, carote, ecc.) o altro? 🥕🥗"))
   (translation (en "🌾 Complementary _grain_ flavors balance hops while remaining light on the palate. 
🌱 _Legumes_ add richness to the beer while balancing salt and acidity. 
🐟🦐 _Fish_ (shellfish) pairs well with fruity and spicy beers, such as saisons and wheat beers. 
🥩🍖 _Meat_ pairs by type: rich meats with sour, tart beers; game birds with hoppy, bitter ales. 
🍆🥦 _Vegetables_ pair well with sour beers (root) or dark, roasty beers (grilled). 
🥜 With _fats_ strong flavors, beer balances and allows for a complex finish.")
                (it "🌾 I sapori complementari dei _cereali_ bilanciano il luppolo restando leggeri al palato. 
🌱 I _legumi_ aggiungono ricchezza alla birra bilanciando sale e acidità. 
🐟🦐 Il _pesce_ (crostacei) si abbina a birre fruttate e speziate, come saison e birre di frumento. 
🥩🍖 La _carne_ si abbina per tipo: carni rosse con birre acide; selvaggina da penna con ale luppolate e amare. 
🍆🥦 Le _verdure_ si abbinano a birre acide (radici) o scure e tostate (alla griglia). 
🥜 Con i sapori forti dei _grassi_, la birra bilancia e consente un finale complesso."))
)
