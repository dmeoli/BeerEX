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

   ; --- preference questions (display) ---

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
   (translation (en "Is the meat spicy? 🌶")
                (it "La carne è piccante? 🌶"))
   (translation (en "Are the vegetables roasted?")
                (it "Le verdure sono arrostite?")))

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
🧀 _Semi-soft_ cheeses have a smooth, generally, creamy interior with little or no rind. These cheeses are generally high in moisture content and range from very mild in flavor to very pungent. 
🧀 _Firm/hard_ cheeses have a taste profiles range from very mild to sharp and pungent. They generally have a texture profile that ranges from elastic, at room temperature, to the hard cheeses that can be grated. 
🧀 _Blue_ cheeses have a distinctive blue/green veining, created when the penicillium roqueforti mold, added during the make process, is exposed to air. This mold provides a distinct flavor to the cheese, which ranges from fairly mild to assertive and pungent. 
🧀 _Natural rind_ cheeses have rinds that are self-formed during the aging process. Generally, no molds or microflora are added, nor is washing used to create the exterior rinds, and those that do exhibit molds and microflora in their rinds get them naturally from the environment. 
🧀 _Washed rind_ cheeses are surface-ripened by washing the cheese throughout the ripening/aging process with brine, beer, wine, brandy, or a mixture of ingredients, which encourages the growth of bacteria. The exterior rind of washed rind cheeses may vary from bright orange to brown, with flavor and aroma profiles that are quite pungent, yet the interior of these cheeses is most often semi-soft and, sometimes, very creamy.")
                (it "🧀 I formaggi _freschi_ non sono stagionati, o lo sono pochissimo. Hanno un alto contenuto di umidità, sono di solito delicati e hanno gusto molto cremoso e consistenza morbida.
🧀 I formaggi _semi-molli_ hanno un interno liscio, in genere cremoso, con poca o nessuna crosta. Sono generalmente ricchi di umidità e vanno da molto delicati a molto pungenti.
🧀 I formaggi _duri_ hanno profili di gusto che vanno da molto delicati a intensi e pungenti. La consistenza va da elastica, a temperatura ambiente, fino ai formaggi duri da grattugiare.
🧀 I formaggi _erborinati_ hanno la caratteristica venatura blu/verde, creata quando la muffa penicillium roqueforti, aggiunta in lavorazione, è esposta all'aria. Dà un sapore distintivo, da abbastanza delicato ad assertivo e pungente.
🧀 I formaggi a _crosta fiorita_ hanno croste che si formano da sole durante la stagionatura. In genere non si aggiungono muffe o microflora, né si usa il lavaggio: quelle presenti arrivano naturalmente dall'ambiente.
🧀 I formaggi a _crosta lavata_ maturano in superficie lavando il formaggio durante la stagionatura con salamoia, birra, vino, brandy o una miscela, favorendo la crescita di batteri. La crosta va dall'arancione acceso al marrone, con profili pungenti, mentre l'interno è spesso semi-molle e talvolta molto cremoso."))
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

;; Atomic fragments: rationale phrases, bot messages.
(deffacts italian-fragment-labels
   (translation (en "pale color") (it "colore chiaro"))
   (translation (en "amber color") (it "colore ambrato"))
   (translation (en "brown color") (it "colore bruno"))
   (translation (en "dark color") (it "colore scuro"))
   (translation (en "light in alcohol") (it "poco alcolica"))
   (translation (en "moderate alcohol") (it "moderatamente alcolica"))
   (translation (en "fairly strong") (it "piuttosto forte"))
   (translation (en "very strong") (it "molto forte"))
   (translation (en "low bitterness") (it "poco amara"))
   (translation (en "medium bitterness") (it "mediamente amara"))
   (translation (en "quite bitter") (it "decisamente amara"))
   (translation (en "fresh and clean taste") (it "gusto fresco e pulito"))
   (translation (en "malty and sweet taste") (it "gusto maltato e dolce"))
   (translation (en "toasty taste") (it "gusto tostato"))
   (translation (en "hoppy and bitter taste") (it "gusto luppolato e amaro"))
   (translation (en "fruity and spiced taste") (it "gusto fruttato e speziato"))
   (translation (en "sour taste") (it "gusto acidulo"))
   (translation (en "lightly fizzy") (it "poco frizzante"))
   (translation (en "moderately fizzy") (it "mediamente frizzante"))
   (translation (en "very fizzy") (it "molto frizzante"))
   (translation (en "paired with your meal") (it "abbinata al tuo pasto"))
   (translation (en "style suits your meal") (it "lo stile si adatta al tuo pasto"))
   (translation (en "matches its CraftBeer pairing") (it "corrisponde all'abbinamento CraftBeer"))
   (translation (en "general match") (it "corrispondenza generale"))
   (translation (en "Hello %s! 🤖") (it "Ciao %s! 🤖"))
   (translation (en "Sorry, I didn't get that. Press a button or /new.") (it "Spiacente, non ho capito. Premi un pulsante o /new."))
   (translation (en "Backend set to *%s*. Press /new to start.") (it "Backend impostato su *%s*. Premi /new per iniziare."))
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

;; Questions as the user sees them and the label of each answer (the codes
;; asserted in working memory stay English, see clips/beer-questions.clp),
;; plus the welcome and the bot buttons.
(deffacts italian-question-labels
   (translation (en "How old are you? 🔞") (it "Quanti anni hai? 🔞"))
   (translation (en "18 to 23") (it "da 18 a 23"))
   (translation (en "24 to 29") (it "da 24 a 29"))
   (translation (en "30 or older") (it "30 o più"))
   (translation (en "Do you drink beer often? 🍺") (it "Bevi birra spesso? 🍺"))
   (translation (en "Yes, often") (it "Sì, spesso"))
   (translation (en "No, now and then") (it "No, ogni tanto"))
   (translation (en "Do you usually smoke while you drink? 🚬") (it "Di solito fumi mentre bevi? 🚬"))
   (translation (en "Yes") (it "Sì"))
   (translation (en "What season is it? 🍁🌱🏖❄️") (it "Che stagione è? 🍁🌱🏖❄️"))
   (translation (en "🍁 Autumn") (it "🍁 Autunno"))
   (translation (en "🌱 Spring") (it "🌱 Primavera"))
   (translation (en "🏖 Summer") (it "🏖 Estate"))
   (translation (en "❄️ Winter") (it "❄️ Inverno"))
   (translation (en "Which colour of beer do you like best? 🍺") (it "Che colore di birra preferisci? 🍺"))
   (translation (en "Light, golden") (it "Chiara, dorata"))
   (translation (en "Amber, copper") (it "Ambrata, ramata"))
   (translation (en "Brown") (it "Bruna"))
   (translation (en "Dark, almost black") (it "Scura, quasi nera"))
   (translation (en "Any is fine") (it "Mi va bene tutto"))
   (translation (en "How strong do you like your drinks? 🍹") (it "Quanto ti piacciono forti le bevande? 🍹"))
   (translation (en "Light") (it "Leggere"))
   (translation (en "Medium") (it "Medie"))
   (translation (en "Strong") (it "Forti"))
   (translation (en "Very strong") (it "Molto forti"))
   (translation (en "How fizzy do you like your drinks? 🍾") (it "Quanto ti piacciono frizzanti le bevande? 🍾"))
   (translation (en "A little") (it "Poco"))
   (translation (en "Moderately") (it "Il giusto"))
   (translation (en "Very fizzy") (it "Molto"))
   (translation (en "Which taste do you enjoy most? 😋") (it "Che gusto ti piace di più? 😋"))
   (translation (en "Fresh and clean") (it "Fresco e pulito"))
   (translation (en "Sweet") (it "Dolce"))
   (translation (en "Bitter") (it "Amaro"))
   (translation (en "Toasty, like coffee") (it "Tostato, come il caffè"))
   (translation (en "Fruity") (it "Fruttato"))
   (translation (en "Spiced") (it "Speziato"))
   (translation (en "Sour, tangy") (it "Acidulo"))
   (translation (en "What are you eating with it? 🍽") (it "Con cosa la bevi? 🍽"))
   (translation (en "🍲 A main dish") (it "🍲 Un piatto principale"))
   (translation (en "🧀 Cheese") (it "🧀 Formaggi"))
   (translation (en "🍰 Dessert") (it "🍰 Un dolce"))
   (translation (en "Something else") (it "Altro"))
   (translation (en "What's on the pizza? 🍕") (it "Com'è condita la pizza? 🍕"))
   (translation (en "Classic (tomato, mozzarella)") (it "Classica (pomodoro, mozzarella)"))
   (translation (en "🥓 Meat or cold cuts") (it "🥓 Carne o salumi"))
   (translation (en "🍆 Vegetables") (it "🍆 Verdure"))
   (translation (en "🧀 Lots of cheese") (it "🧀 Tanto formaggio"))
   (translation (en "Is the meat spicy? 🌶") (it "La carne è piccante? 🌶"))
   (translation (en "Yes, spicy") (it "Sì, piccante"))
   (translation (en "Are the vegetables roasted?") (it "Le verdure sono arrostite?"))
   (translation (en "Yes, roasted") (it "Sì, arrostite"))
   (translation (en "What is the dish mostly made of?") (it "Di cosa è fatto soprattutto il piatto?"))
   (translation (en "🌾 Grains (rice, farro, polenta…)") (it "🌾 Cereali (riso, farro, polenta…)"))
   (translation (en "🌱 Legumes (lentils, chickpeas, beans…)") (it "🌱 Legumi (lenticchie, ceci, fagioli…)"))
   (translation (en "🐟 Fish or seafood") (it "🐟 Pesce o frutti di mare"))
   (translation (en "🥩 Meat") (it "🥩 Carne"))
   (translation (en "🥦 Vegetables") (it "🥦 Verdure"))
   (translation (en "🥑 Rich in fats (avocado, nuts, oil…)") (it "🥑 Ricco di grassi (avocado, frutta secca, olio…)"))
   (translation (en "What kind of fish? 🐟") (it "Che tipo di pesce? 🐟"))
   (translation (en "🦐 Shellfish or molluscs") (it "🦐 Crostacei o molluschi"))
   (translation (en "🐟 Other fish") (it "🐟 Altro pesce"))
   (translation (en "Is it squid, cuttlefish or octopus? 🐙🦑") (it "Sono calamari, seppie o polpo? 🐙🦑"))
   (translation (en "No, something else") (it "No, altro"))
   (translation (en "Which shellfish is it? 🦐🦀🐚") (it "Quali frutti di mare? 🦐🦀🐚"))
   (translation (en "Mussels") (it "Cozze"))
   (translation (en "Oysters") (it "Ostriche"))
   (translation (en "What kind of meat? 🍖") (it "Che tipo di carne? 🍖"))
   (translation (en "🥩 Red meat (beef, lamb, pork)") (it "🥩 Carne rossa (manzo, agnello, maiale)"))
   (translation (en "🐔 Poultry") (it "🐔 Pollame"))
   (translation (en "🦌 Game") (it "🦌 Selvaggina"))
   (translation (en "How is the meat cooked?") (it "Come è cotta la carne?"))
   (translation (en "Braised or stewed") (it "Brasata o in umido"))
   (translation (en "Grilled") (it "Alla griglia"))
   (translation (en "Roasted") (it "Arrosto"))
   (translation (en "Another way") (it "In altro modo"))
   (translation (en "Which red meat?") (it "Quale carne rossa?"))
   (translation (en "Beef") (it "Manzo"))
   (translation (en "Lamb") (it "Agnello"))
   (translation (en "Pork") (it "Maiale"))
   (translation (en "Which beef?") (it "Quale manzo?"))
   (translation (en "Other beef") (it "Altro manzo"))
   (translation (en "Which pork?") (it "Quale maiale?"))
   (translation (en "Loin") (it "Lonza"))
   (translation (en "Sausage or salami") (it "Salsiccia o salame"))
   (translation (en "Which cured meat?") (it "Quale salume?"))
   (translation (en "Spicy salami") (it "Salame piccante"))
   (translation (en "Which poultry? 🦃") (it "Quale pollame? 🦃"))
   (translation (en "Chicken") (it "Pollo"))
   (translation (en "Other (turkey, duck…)") (it "Altro (tacchino, anatra…)"))
   (translation (en "Which game?") (it "Quale selvaggina?"))
   (translation (en "Ground game (boar, venison…)") (it "Di terra (cinghiale, cervo…)"))
   (translation (en "Game birds (duck, quail…)") (it "Da penna (anatra, quaglia…)"))
   (translation (en "Which vegetables? 🥕🥗") (it "Quali verdure? 🥕🥗"))
   (translation (en "🥕 Root vegetables (carrots, parsnips…)") (it "🥕 Radici (carote, pastinaca…)"))
   (translation (en "🥗 Other vegetables") (it "🥗 Altre verdure"))
   (translation (en "How are the vegetables cooked?") (it "Come sono cotte le verdure?"))
   (translation (en "Are they mushrooms? 🍄") (it "Sono funghi? 🍄"))
   (translation (en "🍄 Mushrooms") (it "🍄 Funghi"))
   (translation (en "Where does the fat come from? 🥑🍖") (it "Da dove vengono i grassi? 🥑🍖"))
   (translation (en "🥑 Plants (avocado, olive oil, nuts…)") (it "🥑 Vegetali (avocado, olio d'oliva, frutta secca…)"))
   (translation (en "🍖 Animal or other") (it "🍖 Animali o altro"))
   (translation (en "What kind of cheese? 🧀") (it "Che tipo di formaggio? 🧀"))
   (translation (en "Fresh (ricotta, mascarpone, feta…)") (it "Fresco (ricotta, mascarpone, feta…)"))
   (translation (en "Soft (mozzarella, fontina…)") (it "Morbido (mozzarella, fontina…)"))
   (translation (en "Aged, hard (parmesan, cheddar…)") (it "Stagionato, duro (parmigiano, cheddar…)"))
   (translation (en "Blue (gorgonzola, roquefort…)") (it "Erborinato (gorgonzola, roquefort…)"))
   (translation (en "White rind (brie, camembert…)") (it "Crosta bianca (brie, camembert…)"))
   (translation (en "Strong-smelling (taleggio…)") (it "Dall'odore forte (taleggio…)"))
   (translation (en "Not sure") (it "Non so"))
   (translation (en "Which fresh cheese? 🧀") (it "Quale formaggio fresco? 🧀"))
   (translation (en "Goat's cheese") (it "Caprino"))
   (translation (en "Cream cheese") (it "Formaggio spalmabile"))
   (translation (en "Which soft cheese? 🧀") (it "Quale formaggio morbido? 🧀"))
   (translation (en "Which hard cheese? 🧀") (it "Quale formaggio duro? 🧀"))
   (translation (en "Swiss (Emmental, Gruyère…)") (it "Svizzero (Emmental, Gruyère…)"))
   (translation (en "Parmesan") (it "Parmigiano"))
   (translation (en "What kind of Gouda? 🧀") (it "Che Gouda è? 🧀"))
   (translation (en "Aged") (it "Stagionato"))
   (translation (en "Smoked") (it "Affumicato"))
   (translation (en "Neither") (it "Né l'uno né l'altro"))
   (translation (en "Is the Cheddar white? 🧀") (it "Il Cheddar è bianco? 🧀"))
   (translation (en "White") (it "Bianco"))
   (translation (en "Orange or not sure") (it "Arancione o non so"))
   (translation (en "How aged is the Cheddar? 🧀") (it "Quanto è stagionato il Cheddar? 🧀"))
   (translation (en "Young, mild") (it "Giovane, delicato"))
   (translation (en "Medium-aged") (it "Media stagionatura"))
   (translation (en "Well aged") (it "Molto stagionato"))
   (translation (en "Which Swiss cheese? 🧀") (it "Quale formaggio svizzero? 🧀"))
   (translation (en "Which blue cheese? 🧀") (it "Quale erborinato? 🧀"))
   (translation (en "Another one (gorgonzola…)") (it "Un altro (gorgonzola…)"))
   (translation (en "Which white-rind cheese? 🧀") (it "Quale formaggio a crosta bianca? 🧀"))
   (translation (en "Is it Taleggio? 🧀") (it "È Taleggio? 🧀"))
   (translation (en "Another one") (it "Un altro"))
   (translation (en "What kind of dessert? 🍮🥧🍪🍫") (it "Che dolce è? 🍮🥧🍪🍫"))
   (translation (en "🍮 Creamy (custard, cheesecake…)") (it "🍮 Al cucchiaio (crema, cheesecake…)"))
   (translation (en "🥧 Fruit") (it "🥧 Alla frutta"))
   (translation (en "🍫 Chocolate") (it "🍫 Al cioccolato"))
   (translation (en "Does it have fruit in it?") (it "C'è della frutta?"))
   (translation (en "What kind of chocolate? 🍫") (it "Che cioccolato è? 🍫"))
   (translation (en "Milk") (it "Al latte"))
   (translation (en "Dark, mild") (it "Fondente delicato"))
   (translation (en "Dark, intense") (it "Fondente intenso"))
   (translation (en "Pure cocoa, no sugar") (it "Cacao puro, senza zucchero"))
   (translation (en "Hi! I'm BeerEX 🍻 I suggest a beer style for your taste and your meal.")
                (it "Ciao! Sono BeerEX 🍻 Ti suggerisco uno stile di birra adatto ai tuoi gusti e al tuo pasto."))
   (translation (en "I'll ask you a few quick questions: just tap an answer. Tap ❓ Why to see why I ask, and ◀️ Back to change an answer.")
                (it "Ti farò qualche domanda veloce: basta toccare una risposta. Tocca ❓ Perché per sapere perché te lo chiedo, e ◀️ Indietro per cambiare una risposta."))
   (translation (en "match") (it "affinità"))
   (translation (en " (partly)") (it " (in parte)"))
   (translation (en "🍺 Start") (it "🍺 Inizia"))
   (translation (en "❓ Why") (it "❓ Perché"))
   (translation (en "ℹ️ What do these mean?") (it "ℹ️ Cosa significano?"))
   (translation (en "◀️ Back") (it "◀️ Indietro"))
   (translation (en "🔄 Start over") (it "🔄 Ricomincia"))
   (translation (en "This question is no longer active.") (it "Questa domanda non è più attiva."))
   (translation (en "I don't know that command. Tap /new to start.")
                (it "Non conosco questo comando. Tocca /new per iniziare.")))
