Kérlek olvasd el ezt, ha kérdésed van a programmal kapcsolatban.

Ennek a programnak (TCBR Keretprogram) a célja, hogy könyveket készítsen elõ a mobilon történõ elolvasáshoz, a TequilaCat BookReader (KönyvOlvasó) midlet-et (mobil-alkalmazást) használva.

Ebben a fájlban a keretprogram leírása található. A BookReader midlet-rõl a program honlapját találhatsz további részleteket és információkat:
http://tequilacat.narod.ru/dev/br/
Javaslom, hogy nézd meg a honlapot frissebb verzióért, amely hibajavítással és több funkcióval rendelkezik.

A BookReader keretprogram funkciói:
1. A keretprogrammal készített könyvek fejezetekre oszthatóak, fejezet-fejléc vagy a maximum fejezetméret szerint, amit te határozhatsz meg
2. Számtalan mobiltelefon-márka támogatott: Nokia, Siemens stb.
3. Egy könyv elõkészítésénél betûtípust választhatsz, melyet majd a mobilodon olvashatsz. A betûtípusok között megtalálhatod a Windows állandó szélességû betûtípusait is.
  Eddig csak az állandó szélességû betûtípusok támogatottak, mint a Courier, a következõ verziókban a betûszélesség-arányos betûkészletek is elérhetõek lesznek.
4. Elõ- és háttérszínt is választhatsz a még kényelmesebb olvasáshoz.
5. Számos beállítási lehetõséggel rendelkezhetsz.
6. Ha a keretprogram tartalmaz midlet honosítást, dönthetsz, hogy honosítod-e a midletet, így az összes parancs és menü a telefonos alkalmazásodban az anyanyelveden fog megjelenni.

================================================
A BookReader keretprogram használata:
================================================
1. Nyomd meg a "+" gombot szövegfájl(ok) hozzáadásához a könyvhöz
2. Nyomd meg a "-" gombot szövegfájl(ok) listából való eltávolításához
3. A szövegek átnevezése az "Átnevezés" gombbal hajtható végre. Ez a mobilon látható szöveg-feliratokat változatatja meg.
4. A "Beállítások" fülön válaszd ki a verziót a telefon-márkádhoz és típusodhoz
5. Végezd el a kívánt beállításokat és méret-korlátozásokat (lásd még a Méret-korlátozások részben lejjebb)
  A "Kijelzõ magasságának kiterjesztése" beállítás csak a Motorola és a Samsung telefonoknál alkalmazható, a teljesképernyõs kijelzés elérésének érdekében, a kijelzõ alsó sávjának felhasználásaval, ahol általában a menüparancsok jelennek meg a mobilon.
6. A "Betûtíus" fülön válaszd ki a betûtípusokat és színeket. Válaszd a "A mobilod fontja" gombot hogy helyet spórolj a szöveg számára (1-2 kilobájtnyit), ha a telefonod méret-megkötésekkel rendelkezik (ismételeten lásd alant)
7. Az ablak alján írd be a könyv nevét. Ez a név a telefonban lesz felhasználva, így kérlek csak ékezetmentes betûket (latin ABC betûi) használj, és/vagy számokat,aláhúzásjeleket (_)
8. Válaszd ki a mappát ahova a könyvek kerülnek a "..." gomb megnyomásával. Miután a könyvek elkészültek, megnyithatod ezt a mappát a kiemelt színû elérési útjára való kattintással.
9. Kattints a "Csináld !" gombra a könyvek elkészítéséhez

Megjegyzés: A BookReader midlet csak szövegfájlokat támogat. Ahhoz, hogy MS Word fájlokat olvass, elõször át kell konvertálni õket a Word "Mentés másként..." ("Save As...") menüpontjával, majd kiválasztani a "Csak szöveg" ("Text format") opciót.

A program könyveket generál: néhány JAD és ugyanannyi JAR fájlt, számuk függ a beállításoktól és a szöveg méretétõl. Minden könyv egy JAD és egy JAR fájl párosa.

A JAR fájlok a valódi könyvek - mindegyik tartalmazza a szövegfájlokat és a BookReader midletet. Valójában a JAR fájlok ZIP archívumok .JAR kiterjesztéssel, és bármelyik programmal megvizsgálhatóak, amelyek támogatják a ZIP tömörítést.
A JAD fájlok rövid szövegfájlok, melyek leírják a midletet. Alapvetõen mindegyik JAR fájlnak kell lennie egy megfelõ JAD párjának is, ami leírja az adatait. Néhány telefonnak nincs szüksége JAD fájlokra pl. Sony Ericsson T6x0 és a Motorola Accompli család.

Ha készen állnak a könyvek, akkor telepítsd õket a mobilodra és élvezd az olvasást.
A midlet telepítésrõl további részleteket a telefonod kezelési útmutatójában vagy internetes fórumokban találhatsz - ilyen témában rengeteg hozzászólást találhatsz. Néhány típus (pl. Nokia 3410) ami nem támogat JAVA telepítést kábellel,IRDA-vel vagy BlueTooth-tal, próbáld meg online installálni, úgy, hogy a könyveket elõször feltöltöd egy WAP oldalra, majd onnan a telefonodra.

====================================
GYIK (Fontos!)
====================================

Miért korlátozottak a JAR fájlok és a fejezetek méretei?

A mobiltelefonok kis készülékek korlátozott képességekkel. Egyéb megkötések között a memória mérete sok készüléknél meglehetõsen alacsony. Ennek eredményeképp korlátozások vannak az alkalmazások méretében is.

A kis memóriának köszönhetõen az is ki van kötve, hogy mekkora szövegfájlt tudunk megnyitni egyszerre. Ha egy fejezet mérete túl nagy, akkor a készülék vagy nem tudja betölteni, és egy hibaüzenetet dob ki, vagy szépen csendesen betölti a fejezetet, de annak csak egy részét.
Hogy kikerüljük ezeket a megkötéseket, a TCBR Keretprogram különbözõ fejezetméreteket engedélyez, ezzel változtatva a JAR fájlok méretét.

Problémák és megoldások:

Probléma:
A JAD és a JAR fájlok nem installálhatóak a mobilra vagy nem futnak a sikeres telepítés után sem (olyan hibaüzenetekkel lép ki mint ezek: "Alkalmazás hiba" ("Application Error"), "A fájl túl nagy" ("file too big") stb.)

Megoldás 1:
Az elkészített JAR fájl túl nagy a mobilodhoz - a "Beállítások" fülön korlátozd a JAR fájl méretét.

Megoldás 2:
Rossz midlet verziót választottál - más telefongyártóhoz vagy más típushoz valót. A telefontípusok különböznek az eltérõ funkciók támogatásában amit a BookReader nyújt. Egy másik típusra tervezett BookReader verzió telepítése nagy valószínûséggel sikertelen lesz.

Probléma:
JAR fájl sikeresen települ és fut is, de a tartalmazott könyvek nem nyílnak meg. Vagy megnyílnak, de néhány szövegrész eltûnik (a JAR fájlokban még megtalálhatóak)

Megoldás:
A létrehozott fejezetek túl nagyok, ahhoz hogy a telefonod memóriája kezelni tudja õket. A méret-beállításoknál korlátozd a fejezet-méretet.

Probléma:
Egy csomó fejezet vagy JAR fájl generálódott.

Megoldás:
A méreteket kilobájtban adtad meg (pl. 60) holott bájtokban kellett volna (ebben az esetben 60000).

Javasolt méretek néhány telefontípushoz:

Nokia S40 (Series 40 - ezek a legelterjedtebb Nokiák) - JAR maximum 64000 bájt, fejezet maximum 60000 bájt

SonyEricsson T6x0 és Motorola T720 - A JAR fájl mérete nem korlátozott (vagy 200-300 kilobájt), maximum fejezetméret 120000-150000 bájt.

Ha a telefonod nincs a fentiek között, és hasonló problémákkal találkozol, mint a fentebb leírtak, kísérletezz saját magad.
Vedd a Nokia méreteit (maximum JAR méret vagy maximum fejezet méret, attól függ, milyen jellegû a probléma), és emeld addig, ameddig a telefonod képes azt futtatni.
Hálás lennék (és más Bookreader felhasználók is) ha elküldenéd nekem ezeket a méreteket, hogy szerepelhessenek itt.


A program TequilaCat szerzõi jogvédelme alatt áll, részletekért nézd meg a licence.txt-t.

A program tartalmaz ingyenes programokat (DLL-ként):
* FreeImage eljáráskönyvtár
* infozip' zip eljáráskönyvtár
* ZipBuilder eljáráskönyvtár az infozip' -re építve
Köszönet a szerzõknek, a licenc információt hamarosan mellékelem.
