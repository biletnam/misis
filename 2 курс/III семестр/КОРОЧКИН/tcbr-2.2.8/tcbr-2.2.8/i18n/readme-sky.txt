Prosím preèitaj si toto ak máš otázky oh¾adom programu.

Úèelom tohoto programu (TCBR Shell) je vytvori knihy èitate¾né na mobilnıch telefónoch, s pouitím TequilaCat BookReader midlet-u.

Nišie, je popísané prostredie programu. Blišie informácie a detaily o samotnom midlet-e BookReader-u nájdeš na domovskej stránke programu:
http://tequilacat.narod.ru/dev/br/
Odporúèam skontrolova èi sa na web stránke programu nenachádza novšia verzia, s viacerımi vlastnosami odstránenımi chybami.

Prostredie BookReader-u umoòuje:
1. Knihy vytvorené tımto prostredím môu by rozdelené do èastí, na základe èísla kapitoly alebo by maximalej ve¾kosti ktorú si zvolíš
2. Rôòy znaèky mobilnıch telefónov sú podporované: Nokia, Siemens atï.
3. Keï vytváraš knihu, môeš si zvolipísmo aké sa bude zobrazova na displey-i, zo všetkıch nainštalovanıchpísem vo Windows-e.
  Zatia¾ sú podporované iba štandardné písma ako Courier, v da¾ších verziách budú prístupné aj proporèné písma.
4. Môeš si zvoli farbu pozadia a písma, pre lepšiu èitate¾nos.
5. Môeš si zvoli z nieko¾kıch nastavení pre èítanie.
6. Ak prostredie obsahuje lokalizáciu midlet-u , môeš localizova midlet, tak aj vŠetky príkazy a menu v aplikácii telefónu budú zobrazené v tvojom rodnom jazyku.

================================================
Ako pouíva prostredie BookReader-u:
================================================
1. Stlaè tlaèidlo "+" na pridanie textového súboru(ov) ktoré chceš prida do knihy
2. Stlaè tlaèidlo "-" na odstránenie textov zo zoznamu
3. Premenuj texty pouitím tlaèidla "Premenuj" na zmenu názvov ktoré budeš vidie v telefóne
4. V záloke "Nastavenia", zvo¾ verziu zodpovedajúcu vırobcovy tvojho telefónu a modelu
5. Zvo¾ poadované nastavenia a obmedzenia ve¾kosti (viac si preèítaj o obmedzeniach ve¾kosti nišie)
  Nastavenie "Zmeò ve¾kos obrazovky o" je pouie¾né iba u telefónov Motorola a Samsung , na povolenie celoobrazovkového zobrazenia pouitím hustejšieho riadkovania obrazovky kde sa obyèajne zobrazujú príkazy.

6. V záloke "Písma", zvo¾ písmo a farby. Vyber "Poui písmo telefónu" na vyuitie priestoru pre knihy (1-2 kilobytes textu), ak tvoj telefón má obmedzenie ve¾kosti (opä, pozri nišie)
7. Napíš meno knihy na spodku okna. Toto meno bude pouité v telefóne, tak poui proím len písmená latinka, èísla a podtrítka.
8. Zvo¾ adresár do ktorého budú vygenerované knihy, stlaèením tlaèidla "...". Keï vytvoríš knihy, môes otvori tento adresár kliknutím na jeho zvıraznenú cestu.
9. Klikni "Vytvor!" na vytvorenie kníh

Zapamätaj si prosím: Midlet BookReader-u podporuje iba textové súbory. Na èítanie súborov MS Word-u musíš ich  najskôr skonvertova do textového formátu, tım e ich uloíš pouitím "Ulo ako..." a zvolíš "Text formát"

Tento program generuje knihy: páry súborov JAD a JAR, ich poèet závisí na zvolenıch nastaveniach a ve¾kosti textu. Kadá kniha je tvorená párom JAR a JAD súborov.

JAR súbor obsahuje knihy - kadı obsahuje textové súbory a midlet BookReader-u. V podstate JAR súbory sú ZIP archívy s príponou .JAR, a môu by prezerané akımko¾vek archivaènım programom podporujúcim ZIP kompresiu.
JAD súbory sú krátke textové súbory popisujúce midlety. Všeobecne kadı JAR súbor by mal ma rovnakı JAD súbor ktorı popisuje jeho vlastnosti. Niektoré telefóny nepotrebujú JAD súbory, napr. SE T6x0 a Motorola Accompli.

Po vytvorení kníh, nahraj ich do telefónu a môeš zaèa èíta.
Viac detailov ako nahra vytvorené midlety (.jar súbory) získaš v manuály svojho mobilného telefónu alebo internetovıch fórach - tu je dostatok dostatok informácií na túto tému. Pre niektoré modely (napríklad Nokia 3410) ktoré nepodporujú  priame nahrávanie Java midletov prostredníctvom kábla, IRDA alebo BlueTooth, je stále monos nahra ich vzduchom cez WAP, tu ale musíš vygenerované knihy uploadnú najprv na WAP stránku.

====================================
FAQ (Dôleité!)
====================================

Preèo obmedzova ve¾kos JAR súborov a textovıch dokumentov?

Mobilné telefóny sú malé zariadnia s obmedzenımi monosami. Na margo ostatnıch reštrikcií, ve¾kos pamäte tıchto zariadení je niekedy moc malá. Ako reštrikciu, vırobcovia mobilnıch telefónov limitujú maximálnu ve¾kos aplikácií.

Takisto kvôli malej pamäte, sú obmedzenia aj vo ve¾kosti jednorázovo otváraného textu. Ak je jedna jeho èas príliš ve¾ká, telefón ju nedokáe otvori, Buï sa zobrazí chyba, alebo sa nahrá nekompletnı text.

Na obídenie tıchto reštrikcií, TCBR Shell umonje rozdeli text do jednotlivıch èastí, èo má vpliv na ve¾kos JAR súboru.

Take, ak máš nasledujúce problémy:

Problém:
JAD a JAR súbory sa nedajú nahra do telefónu, alebo nemôu by spustené po úspešnom nahratí (s chybami ako napríklad "Chyba aplikácie", "súbor prive¾kı" atï.)

Riešenie 1:
vytvornı JAR súbor je príliš ve¾kı pre tvoj telefón - prosím obmedz ve¾kos JAR súboru v záloke "Nastavenia".

Riešenie 2:
Vybral si si zlú verziu midletu - od iného vırobcu mobilného telefónu, alebo pre inı model telefónu. Modely telefónov sa odlišujú v podpore rôznych nastavení pouitıch bookreaderom. Inštalovanie verzie bookreaderu vytvoreného pre inı model väèšinou havaruje.

Problém:
JAR súbor sa úspešne nahrá a beí, ale obsiahnuté knihy nemôu by otvorené. Alebo, knihu je moné otvori ale èas textu sa stratí (v porovnaní s textom ktorı môeš nájs obsiahnutı v JAR archíve)

Riešenie:
Generované èasti sú príliš ve¾ké aby sa zmestili do pamäi tvojho telefónu. Prosím zmenši ve¾kos èastí textu v nastaveniach.

Problém:
Je generované ve¾ké mnostvo textov v JAR súbore, alebo ve¾a JAR súborov.

Riešenie:
Špecifikoval si ve¾kos v kilobytoch (napr. 60) ale ve¾kos musí by v bytoch (v tomto prípade je správne, 60000).

Doporuèené ve¾kosti pre niektoré telefóny sú:

Nokia S40 (Je ve¾ké mnostvo Nokia telefónov) - JAR max 64000, Text max 60000

SonyEricsson T6x0 a Motorola T720 - ve¾kos JAR sa zdá by neobmedzená (alebo 200-300 kb), max ve¾kos textu je 120000-150000.

Ak tu nie je uvedenı tvoj telefón, a spozoruješ problémy, vyskúšaj sám iné èísla.
Poui ve¾kosti pre Nokiu (max JAR ve¾kos alebo max ve¾kos textu v závyslosti akı máš problém), vyskúšaj a nájdi èo ti bude vyhovova.
Budem opatrnı (a ostatní pouívatelia Bookreaderu tie) ak mi pošleš tieto ve¾kosti aby som ich tu uviedol.



Tento program je pod ochrannou známkou TequilaCat, pozri detaily license.txt.

Pouitı ostatnı free software (ako DLL):
* FreeImage kninice
* infozip' zip kninice
* ZipBuilder kninice súèasou infozip' zip kniníc
Ïakujem ich autorom, èoskoro pridám licenèné info.
