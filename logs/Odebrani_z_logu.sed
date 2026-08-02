# Odebrani_z_logu.sed 1.0
# Roma
#---------------------------------------------------------------------
/ : Vyléèeno [0-9]* ivotù.$/d
/ Hledat okolní surovinové zdroje.$/d
/ Nalezl jsi surovinové zdroje:/d
/ Nemùeš meditovat dvakrát tak brzo po sobì.$/d
/ Odpoèinek pøerušen.$/d
/ Pomocí tohoto nástroje mùeš kontrolovat pokroèilé funkce své post/d
/ Postava uloena.$/d
/ pouívá zvláštní schopnost pøedmìtu.$/d
# se pøipojil/odpojil jako hrac
/ se .* jako hráè..$/d
/ Schopnosti sbìru a dolování.$/d
/ U jaké své schopnosti sbìru a dolování si pøeješ prozkoumat své di/d
/ Uloení postavy.$/d
/ V bezprostøedním okolí nemáš nic o èem víš e by šlo tìit. Moná /d
/ V nejbliším okolí jsi to ji v.*, pøesuò se o kus dál./d
/ Zaèít vyuívat nejbliší známı surovinovı zdroj.$/d
/ Zkoušíš hledat zdroje pøíliš rychle po sobì. Poèkej ještì chvíli.$/d
/: \*jí: ./d
/: Co chceš s èutorou udìlat?$/d
/: Jakou emoci chceš pouít?$/d
/: Nabrat vodu.$/d
/: Napít se douškem.$/d
/: Odejít$/d
/: Postih k dovednosti za brnìní: ./d
/\] .$/d
/\] Aktuální dìní nalezneš na fóru hry www.equilibrie.cz\/forum./d
# jste nyni v oblasti plne/zadne HxH
/\] Jste nyní v oblasti .* HxH/d
/\] Konec odpoèinku$/d
/\] Kontrola oprávnìnosti pouívat postavy na úètu /d
/\] Musíš chvíli poèkat ne zaèneš znovu.$/d
/\] Na druhé stranì pøechodu je klid.$/d
/\] Naposledy jsi mìl.* ivotù/d
/\] Nemùeš odpoèívat, kdy jsou poblí nepøátelé.$/d
/\] Odpoèinek$/d
/\] Ohòištì: Stojíš u ohništì, co chceš udìlat?$/d
/\] Podrobné informace o høe najdeš na stránkách www.equilibrie.cz/d
/\] Pohled Zhora dolù aktivován$/d
/\] Pouil jsi klíè.$/d
/\] Pouívanı pøedmìt byl pøehozen.$/d
/\] Pouíváš nìkolik pøedmìtù, které dávají bonus k ./d
/\] Øízená kamera aktivována$/d
/\] Spánek pøerušen. Odpoèala jsi si jen trochu.$/d
/\] Tady se nedá odpoèívat.$/d
/\] Tato èinnost není v tvém souèasném stavu povolena.$/d
/\] Tento objekt je zamèen.$/d
/\] Tento pøedmìt nemùeš pouít.$/d
/\] Vítej na Equilibrii.$/d
# ziskane/ztracene zkusenosti
/\] Z.*né zkušenosti: [0-9]/d
/\] Zbraò se pouívá jako jednoruèní zbraò.$/d
/CHYBA: PØÍLIŠ MNOHO INSTRUKCÍ$/d
#---------------------------------------------------------------------
#-Stavy-postavy-------------------------------------------------------
/ Bolí tì hlava a je ti malátnì a špatnì od aludku.$/d
/ Je ti nesmírnì zle od aludku.$/d
/ Jsi pøetíen a nemùeš jít normální rychlostí.$/d
/ Jsi pøetíen a nemùeš utíkat.$/d
/ Strašnì tì svìdí hlava a chceš se všude drbat.$/d
/\] Je ti dost teplo.$/d
/\] Je ti trochu teplo.$/d
/\] Je ti trochu zima.$/d
/\] Jsi zcela napojen./d
/\] Jsi zcela zasycen./d
/\] Krásnì jsi si odpoèinul./d
/\] Máš u dost velkou ízeò.$/d
/\] Máš u dost velkı hlad.$/d
/\] Necítíš se dobøe a bolí tì v krku.$/d
/\] Oèi se ti zavírají a mysl odmítá pracovat. Chce se ti jen spát/d
/\] Pokud si co nejrychleji neodpoèineš tak riskuješ smrt vyèerpán/d
/\] Zaèíná se ti chtít spát.$/d
/\] Zaèínáš bıt unaven./d
/\] Zaèínáš mít hlad.$/d
/\] Zaèínáš mít ízeò.$/d
/\] aludek se ti svíjí v køeèích a chce se ti køièet: jíííst!$/d
#---------------------------------------------------------------------
#-Boj-----------------------------------------------------------------
/ : Hod na iniciativu : [0-9]/d
/ se snaí odolat kouzlu : ....../d
/: Imunita na sraení./d
/: Imunita na zranìní pohltila [0-9]/d
/: Odolnost na zranìní pohltila [0-9]/d
/: Sníení zranìní pohltilo [0-9]/d
/\] Vyhr.* jsi souboj vùle./d
# odebere všechny vıpoèty zranìní, 
# napøíklad: zranil : 5 (5 fyzické)
/: [0-9]* ([0-9]* [a-zA-Z]/d
# odebrere všechny vıpoèty úspìšnosti
# napøíklad: *odolal* : (5 + 5 = 10 proti TO: 8)
/\* : ([0-9]* . [0-9]/d
/\] Test obranného sesílání úspìšnı./d
/\] Dochází ti støelivo! U ti ho zbıvá jenom [0-9][0-9]!/d
#---------------------------------------------------------------------
#-Magie-sesílání-kouzel-----------------------------------------------
/ sesílání Balagarnùv eleznı roh$/d
/ sesílání Barevná sprška$/d
/ sesílání Bigbyho .* ruka$/d
/ sesílání Bitevní vøava$/d
/ sesílání Bolest$/d
/ sesílání Bıèí síla$/d
/ sesílání Cejch$/d
/ sesílání Èasovı posun$/d
/ sesílání Démonické vyvolávání .. tøídy$/d
/ sesílání Doména Klam, Boskı klam$/d
/ sesílání Dotyk ghùla$/d
/ sesílání Dr osobu$/d
/ sesílání Dr pøíšeru$/d
/ sesílání Elementální štít$/d
/ sesílání Elvíøin pokroèilı ohòostroj$/d
/ sesílání Evardova èerná chapadla$/d
/ sesílání Gedleeho elektrická smyèka$/d
/ sesílání Hoøící ruce$/d
/ sesílání Hromadné zmámení$/d
/ sesílání Hromadnı spìch$/d
/ sesílání Isaacova .* bouøe støel$/d
/ sesílání Jasnozøivost\/Jasné slyšení$/d
/ sesílání Jednota s pøírodou$/d
/ sesílání Kámen na maso$/d
/ sesílání Kamenná kùe$/d
/ sesílání Kamenné kosti$/d
/ sesílání Kladivo bohù$/d
/ sesílání Koèièí elegance$/d
/ sesílání Koule neviditelnosti$/d
/ sesílání Kouzelná støela$/d
/ sesílání Kouzelná zbraò$/d
/ sesílání Kouzelné brnìní$/d
/ sesílání Kulovı blesk$/d
/ sesílání Kùra$/d
/ sesílání Kuel mrazu$/d
/ sesílání Kvílení bánší$/d
/ sesílání Léèivı kruh$/d
/ sesílání Lepší útoèištì$/d
/ sesílání Lišèí mazanost$/d
/ sesílání Magická odolnost$/d
/ sesílání Maskování$/d
/ sesílání Maso na kámen$/d
/ sesílání Melfùv kyselinovı šíp$/d
/ sesílání Mìòavec, Smrtící slaad$/d
/ sesílání Mestilùv kyselinovı dech$/d
/ sesílání Modlitba$/d
/ sesílání Mordenkainenovo rozpojení$/d
/ sesílání Mordenkainenùv meè$/d
/ sesílání Nadpozemská záøe$/d
/ sesílání Nákaza$/d
/ sesílání Nastol pìkné poèasí$/d
/ sesílání Neurèitı štít$/d
/ sesílání Neviditelnost$/d
/ sesílání neznámé kouzlo$/d
/ sesílání Oblak zmatení$/d
/ sesílání Obraz$/d
/ sesílání Odolej elementùm$/d
/ sesílání Odolnost$/d
/ sesílání Odraz smrt$/d
/ sesílání Ohnivá koule$/d
/ sesílání Ochrana pøed dobrem$/d
/ sesílání Ochrana pøed elementy$/d
/ sesílání Ochrana pøed kouzly$/d
/ sesílání Ochrana pøed negativní energií$/d
/ sesílání Ochrana pøed zlem$/d
/ sesílání Ochrannı kruh proti zlu$/d
/ sesílání Orlí nádhera$/d
/ sesílání Oslabení$/d
/ sesílání Ostrá èepel$/d
/ sesílání Ovládni osobu$/d
/ sesílání Paprsek mrazu$/d
/ sesílání Paprsek negativní energie$/d
/ sesílání Paprsek oslabení$/d
/ sesílání Pavuèina$/d
/ sesílání Plamen$/d
/ sesílání Plamenná zbraò$/d
/ sesílání Plamennı šíp$/d
/ sesílání Posílení$/d
/ sesílání Poehnání$/d
/ sesílání Pravdivé vidìní$/d
/ sesílání Pravı úder$/d
/ sesílání Prohlédni neviditelnost$/d
/ sesílání Proklej$/d
/ sesílání Promìò svùj vzhled$/d
/ sesílání Promìna, Démon$/d
/ sesílání Promìna, Klepetnatec okrovı$/d
/ sesílání Promìna, Obøí pavouk$/d
/ sesílání Promìna, Trol$/d
/ sesílání Propuštìní$/d
/ sesílání Prst smrti$/d
/ sesílání Pøedtucha$/d
/ sesílání Pøízraènı zabiják$/d
/ sesílání Rána elektøinou$/d
/ sesílání Rozjasnìní$/d
/ sesílání Rozptyl kouzla$/d
/ sesílání Sádlo$/d
/ sesílání Sférální brána$/d
/ sesílání Shelgarnova trvalá dıka$/d
/ sesílání Silnìjší kamenná kùe$/d
/ sesílání Silnìjší kouzelná zbraò$/d
/ sesílání Silnìjší obnova$/d
/ sesílání Silnìjší rozptılení$/d
/ sesílání Skrytá kamenná kùe$/d
/ sesílání Slabší chaotické vyvolávání$/d
/ sesílání Slabší obnova$/d
/ sesílání Slabší ochrannı pláš$/d
/ sesílání Slabší prolomení kouzla$/d
/ sesílání Slabší rozptılení$/d
/ sesílání Slabší svázání plání$/d
/ sesílání Slabší vyèištìní mysli$/d
/ sesílání Slepota\/Hluchota$/d
/ sesílání Slovo moci, Omraè$/d
/ sesílání Slovo moci, Zabij$/d
/ sesílání Smrdící mrak$/d
/ sesílání Smrtící mrak$/d
/ sesílání Smùla$/d
/ sesílání Soví moudrost$/d
/ sesílání Spalující svìtlo$/d
/ sesílání Spánek$/d
/ sesílání Spìch$/d
/ sesílání Spìšnı ústup$/d
/ sesílání Sršící koule$/d
/ sesílání Stínové vyvolání, Kouzelné brnìní$/d
/ sesílání Stínové vyvolání, Neviditelnost$/d
/ sesílání Stínovı štít$/d
/ sesílání Strach$/d
/ sesílání Støední chaotické vyvolávání$/d
/ sesílání Støední vzıvání chaosu$/d
/ sesílání Svázání plání$/d
/ sesílání Svìtlo$/d
/ sesílání Štít víry$/d
/ sesílání Štít$/d
/ sesílání Tashin hroznı smích$/d
/ sesílání Telekineze$/d
/ sesílání Temnota$/d
/ sesílání Temnı oheò$/d
/ sesílání Tenserova promìna$/d
/ sesílání Tlumiè energie$/d
/ sesílání Trvalı plamen$/d
/ sesílání Ubli nemrtvım$/d
/ sesílání Ultravidìní$/d
/ sesílání Upíøí dotyk$/d
/ sesílání Urèení$/d
/ sesílání Uzdrav$/d
/ sesílání Vìtší pøenos ivotní síly$/d
/ sesílání Volnost pohybu$/d
/ sesílání Vıbuch negativní energie$/d
/ sesílání Vyèištìní mysli$/d
/ sesílání Vydr elementy$/d
/ sesílání Vıheò$/d
/ sesílání Vyleè .* zranìní$/d
/ sesílání Vyléè nachlazení$/d
/ sesílání Vyléè sebe IV$/d
/ sesílání Vylepšená neviditelnost$/d
/ sesílání Vysaj magii$/d
/ sesílání Vystrašení$/d
/ sesílání Vytrvalost$/d
/ sesílání Vytvoø iluzi [A-Z].*/d
/ sesílání Vytvoø nemrtvého$/d
/ sesílání Vyvolání pøedmìtu$/d
/ sesílání Vyvolej bytost [A-Z].*/d
/ sesílání Vyvolej bytost 0$/d
/ sesílání Vzhled ducha$/d
/ sesílání Vzkøíšení$/d
/ sesílání Zapuzení$/d
/ sesílání Závan vìtru$/d
/ sesílání Zbroj smrti$/d
/ sesílání Zjisti èas$/d
/ sesílání Zjisti kletbu$/d
/ sesílání Zmam osobu$/d
/ sesílání Zmam pøíšeru$/d
/ sesílání Zmatení$/d
/ sesílání Zpomalení$/d
/ sesílání Zruš iluzi$/d
/ sesílání Zruš nakouzlení$/d
/ sesílání Zvuková iluze$/d
/ sesílání eleznı aludek$/d
/ vyvolává pøítelíèka.$/d
/\] Návrat do toku èasu za ../d
#---------------------------------------------------------------------
#-Nástìnka------------------------------------------------------------
/\] Nástìnka pro vzkazy: Vzkazy na nástìnce:$/d
/: +-- Pøedchozí vzkazy$/d
/: --+ Další vzkazy$/d
#---------------------------------------------------------------------
#-Chyby-pøi-psani-----------------------------------------------------
# nahradi tri a vice tecek vypustkou
/\.\.\.\./s/\.\.\.\./.../g
/\.\.\.\./s/\.\.\.\./.../g
/\.\.\./s/\.\.\./…/g
/… …/s/… …/…/g
# doplni nenapsanou "*"
/\* \*/s/\* \*/*/g
/\*\*/s/\*\*/*/g
/\*.*\*/!s/\*/**/g
#---------------------------------------------------------------------
#-PLACOS-a-jiné-systémy-----------------------------------------------
/: Informace o postavì a modulu.$/d
/: Jaké informace o své postavì si pøeješ?$/d
/: Jak mou postavu hodnotí PLACOS?$/d
/\] ===============================$/d
/\] ===========================$/d
/ - PLACOS PGR hodnocení:$/d
/\] + .x plus$/d
/\] + okolí nuly.$/d
/\] + Tvá hra je plnì v poøádku. ../d
/\] ---------------------$/d
/ - co máš pokleslé ale pøebité pozitivy:$/d
/\] + nemusíš omezovat ádnı aspekt tvé hry$/d
/ - èas na regeneraci:$/d
/\] Od .. min do .. min.$/d
/\] Tak dlouho bude pøiblinì trvat aby se tvé hodnocení vrátilo /d
/\] Doba je uvádìna v reálném èasu a tento èas musíš skuteènì ode/d
/\] Varování - tvá postava právì dosáhla ... limitu nárùstu bohat/d
/\] Tvá postava vyèerpala limit pro zisk bohatství za èas. Nyní m/d
/: ISA Ochrana tvého úètu./d
/Zde máš monost zapnout ochranu celého tvého úètu a tím všech po/d
/Tuto ochranu si proto nezapínej pokud èasto mìníš své CD klíèe! /d
/: Aktivovat ISA ochranu úètu./d
/: Skuteènì chceš aktivovat ISA ochranu úètu?/d
/Systém ISA ochrany úètu Roma_CZ aktivován./d
/\] DEBUG - iPlaceCounter/d
/\] \*! MAKRO TEST !\*$/d
/\] !!!----------!!!$/d
/\] Systém shledal tvou postavu podezøelou z ovládání makrem.$/d
/\] Do 60 sec prosím pouij odbornost èi runu Gesta a emoce. Staè/d
/\] Do 60 sec prosím pouij odbornost èi runu Pokroèilé ovládání /d
/\] \*! pøeèti si informaci dùleitou vıše !\*$/d
/\] Test na makro hru splnìn v poøádku. Dìkuji.$/d
/: Tento nástroj umoòuje postavì pøenést èást svıch zkušeností n/d
/Tímto zpùsobem je umonìno vytváøení dvojic mentor-ák s monost/d
#---------------------------------------------------------------------
#-Komunikace-s-NPC----------------------------------------------------
/: Ano, m.* pa.*\.\.\. co ode mì potøebuješ?/d
/: Dáváte si s pøítelíèkem hádanky. Samotného tì pøekvapilo, e vymy/d
/: Pohraj si s pøítelíèkem.$/d
/\: Vlastnì nic, chci nìco jiného./d
/\] Alchymista Saldo Vypijto: Pokud to bude v mé moci a tvé platební /d
/\] Alchymista Saldo Vypijto: Vykoupím dìvèe, vykoupím. Uka co máš? /d
/\] Bankovní úøedník Marto Delmer: Vítejte v Tirínská bance milostpan/d
/\] Bankovní úøedník Mildor Danoscia: Vítejte v Tirínské bance milost/d
/\] Diblík Svaèinka: Tak se podívejte ma mojí nabídku a vyberte si. N/d
/\] Hospodskı Koátko: Jestli to máš èerstvé tak proè ne. Dejte to na/d
/\] Hospodskı Koátko: Jistì milostpaní podívejte se do jídelního lís/d
/\] Hospodskı Mardo: No. Je tu devìt pokojù. Nejlepší je devítka podk/d
/\] Klenotník Jaren Krouek: Budou-li pìkné tak ano. Polote je prosí/d
/\] Koešník Quango: Vıbornì! A pokud nejsou potrhané a zašpinìná tak/d
/\] Lektor Goblius Kratiknot: Pro èleny univerzity jsou ceny niší. V/d
/\] Mistr Iluzí Isvarlilion: Pokud jsou nìjaké zajímavé nebo vzácnìjš/d
/\] Obchodnice Kestra: Vyber si co potøebuješ a pøijï mi to zaplatit./d
/\] Objekt je zaneprázdnìn a nemùe s tebou právì mluvit.$/d
/\] Pokladník Golmos Hulva: Dobøe, vzpomínám si na tebe. Take si chc/d
/\] Švadlena Jehlièka Adomerai: Ale ovšem. Díry zašiji, potrhané švy /d
/\] Švadlena Jehlièka Adomerai: Mám se tedy do toho pustit?/d
/\] Švadlena Jehlièka Adomerai: Vykoupím pokud bude èistá. Dejte ji t/d
/\] Veleknìz Lastur: Ale ovšem, milerád. Uvolnìte se a zaèneme./d
/\] Veleknìz Lastur: Ovšem, léèba poskytovaná našim øádem je bezplatn/d
/\] Veleknìz Lastur: Vítejte v chrámu Mocnosti Labira! Co pro vás mù/d
/\] Vetešník Frilo: Však to není problém. Dejte to semhle do vıkupní /d
#---------------------------------------------------------------------
#-Knihy---------------------------------------------------------------
/: Kniha obšírnì a podrobnì objasòuje techniky pro vytváøení portálù/d 
/: V knize je obšírnì, ale celkem jasnì popisované jak sesílat kouzl/d
/: Kniha obšírnì popisuje techniky uívané pøi sesílání kouzel. S jì/d
/: Jaké svìtlo si pøeješ nastavit pro kouzla Svìtlo a Trvalı plamen?$/d
/: Zjistit nastavení knihy./d
/\] Démonické vyvolávání ..tøídy nastaveno na:/d
/: Zpìt na obsah.$/d
/: Zavøít knihu.$/d
#---------------------------------------------------------------------
#-Dodatky-EQ4---------------------------------------------------------
/: \*cosi hledá\*$/d
/\] \*cosi hledá\*$/d
/\] Nepovedlo se.$/d
/\] U je vše vytìeno. Zkus to za nìjakı èas.$/d
/: \*hledá houby\*$/d
/\] \*hledá houby\*$/d
/\] Máš ízeò.$/d
/\] Máš u vánì ízeò a sucho v puse.$/d
/: \*nepovedlo se\*$/d
/\] Máš velkı hlad.$/d
/: Opéci maso nad ohnìm.$/d
/: \*stahuje z kùe\*$/d
/: \*porcuje maso\*$/d
/ - Zvítìzila jsi v souboji vùlí.$/d
/\] Postava nebyla uloena - je promìnìna.$/d
/ - Prohrála jsi v souboji vùlí.$/d
/\] Získanı pøedmìt:/d
/\] Ztracenı pøedmìt:/d
/: \*rıuje\*$/d
/: Opéci maso nad ohnìm.$/d
/: \*opéká koroptvièku\*$/d
/: \*opéká maso\*$/d
/: \*hledá mušle\*$/d
/\] \*hledá mušle\*$/d
/: A nekoupíte kvìtiny vy ode mne?$/d
/: Moná, kdy budou pìkné a neuvadlé. Dejte je do košíku, podívám se na nì.$/d
/: Rovnou prodám to v košíku.$/d
/: \*usmívá se\* Take to celkem dìlá .* Myslím e je to dobrá cena.$/d
/: Vítejte .* Nekoupíte si kvìtiny? Koukejte jak jsou krásné!$/d
/: Dìkuji, pøijïte zas!$/d
/\] Odeslán poadavek na export. Èekám na odpovìï/d
/\] Postava byla úspìšnì vyexportována.$/d
/\] Krásnì sis odpoèinula.$/d
/: Nekoupíte nìjaké lesní plody do kuchynì? Bobule, houby a tak?$/d
/\] Hostinská Zdislava: Ráda, dejte mi je prosím tady na váhu./d
/\] Hostinská Zdislava: Dìkuji, nashledanou.$/d
/: Dobøe, prodám všechno na váze.$/d
/\] Hostinská Zdislava: Take to celkem dìlá .*/d
/\] Mithallirské podhradí, hostinec .U zdi.: Pronájem vyprší za.*/d
/\] Klenotník Delvin: Dobrej dobrej, nesete mi nìjakı kameny nebo snad mušle? Hoïte to rovnou na váhu a já se na to podívám/d
/: Jasnì, nesu nìco k prodeji.$/d
/\] Klenotník Delvin: Mrknu se na to.$/d
/: Rovnou mi dejte peníze za všechno, co je na váze.$/d
/\] Klenotník Delvin: Take to celkem dìlá.*/d
/\] Vetešník Timo Beruvše: Nazdar, já jsem Timo Beruvše. Pøišel jsi nìco koupit nebo prodat?$/d
/\] Vetešník Timo Beruvše: Dobøe, dobøe. Dej to semhle do vıkupní truhly a já to ocením.$/d
/: Dobøe, prodám to.$/d
/\] Vetešník Timo Beruvše: Take to celkem dìlá .*/d
/\] Švec Mára Jasan: Dobrej, jsem Jasan. Mára. \*Vesele se usmìje.\*$/d
/\] Švec Mára Jasan: Máte zájem o òákou koenou zbroj nebo novı boty?$/d
/: Chtìla bych si nechat nìco opravit.$/d
/\] Švec Mára Jasan: Jasan! Sem s tím.$/d
/\] Alariel Erna: Tady to máte a opravde rovnou i to co mám v batohu.$/d
/\] Švec Mára Jasan: Take za kompletní opravu to bude .*/d
/\] .* - opraveno.$/d
/\] Kováø Garnes: Dobrej den. Dobøe, e jdete sem, mám to nejlepší zboí v celım mìstì. \*Bodøe se usmìje\*$/d
/: Umíte také opravovat zbranì a zbroje?$/d
/\] Kováø Garnes: Samozøejmì. Jestli chcete, tak se na to hned podívám.$/d
/: Tady to je všechno a opravte i to z mého batohu$/d
/\] Kováø Garnes: Take za kompletní opravu to bude .*/d
/\] Vrchní pradlena Fialkına Mydlinková: Dobrı den, vítejte v naší prádelnì. Vaše šaty vám vypereme, vyehlíme, pøišijeme upadlı knoflík a zalátáme nìjakou tu díru. Vaše šaty dáme hned do poøádku.$/d
/: Nemohla by jste mi vyprat a opravit šaty hned?$/d
/\] Vrchní pradlena Fialkına Mydlinková: Ale jistì. \*usmìje se\*$/d
/: Tady jsou. \*podává šaty i ty z batohu\*$/d
/\] Vrchní pradlena Fialkına Mydlinková: Take za kompletní opravu to bude .*/d
/\] Mág Ternes: Kdo mì to zase ruší ve studiu?$/d
/: Nevykoupíte magické zboí?$/d
/\] Mág Ternes: Moná. Dej co máš tady do té truhlièky.$/d
/: Rovnou to prodám.$/d
/: Chci prodat nìjaké kùe.$/d
/\] Švec Mára Jasan: Mùete mi je hodit tam na tu hromadu? $/d
/: Tady to máte. Dejte mi rovnou peníze.$/d
/\] Švec Mára Jasan: Take to celkem dìlá .*/d
/\] Švec Mára Jasan: Ajris s vámi!$/d
/\] Tady nelze nabrat vodu.$/d
/\] Cíl nemá pøedmìty ani zlato.$/d
/\] Ovládnut .*/d
/\] \*stahuje z kùe\*$/d
/\] U neovládáš .*$/d
/\] Nelze se dostat k cíli!$/d
/\] \*porcuje maso\*$/d
/\] Cíl musí vìdìt, e tuto schopnost pouíváš.$/d
/\] Nepovedlo se ti stáhnout kùi.$/d
/: Chtìla bych pokoj.$/d
/\] Hostinská Zdislava: Jistì. Máme osm pokojù a horkou lázeò. Nejlepší z pokojù je devítka, to je podkrovní apartmá za 8 støíbrnıch./d
/: Chci pokoj èíslo .*/d
/\] Hostinská Zdislava: Zde je váš klíè.$/d
/\] Kramáøka Rozárka: Pokud jsou pìkné tak ano, dejte je do košíku a uvidíme.$/d
/\] Kramáøka Rozárka: Take to celkem dìlá .*/d
/\] Kramáøka Rozárka: Vítejte má paní v mém krámku.$/d
/\] Hostinská Zdislava: Vítejte u nás! Jsem hostinská Zdislava. \*mile se usmìje\*$/d


#---------------------------------------------------------------------




