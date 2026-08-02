# Pisari.sed 1.0
# Roma

/\: Hotovo/ {
# jestliže první øádek obsahuje :Hotovo pøidej další øádek
	N
	# pokud pøidaný øádek obsahuje jeden z tìchto výrazù skoè na :skop_hotovo
	/Knižní démonek: Tak jsem to zapsal./b skip_hotovo
	/Knižní démonek: Tak titulek už mám./b skip_hotovo
	/Knižní démonek: Tak a mám i ten tex/b skip_hotovo
	/Poštovní písaø Alghab Peroøízek: Na/b skip_hotovo
	/Poštovní písaø Alghab Peroøízek: Ta/b skip_hotovo
	/Písaø Falfaglin Solia: Nadiktuj mi /b skip_hotovo
	/Písaø Falfaglin Solia: Takže zprávu/b skip_hotovo
	/Kragzug Škrábal: Nadiktujte mi zprá/b skip_hotovo
	/Kragzug Škrábal: Má paní zprávu jse/b skip_hotovo
	/Poštovní úøednice Elvíra: Nadiktuj /b skip_hotovo
	/Poštovní úøednice Elvíra: tady je v/b skip_hotovo
	# skoè na :skip_konec
	b skip_konec 
	:skip_hotovo
	s/.*: Hotovo\.//
	s/.*: Hotovo//
	P
	D
	:skip_konec
}		

/: Zapiš další vìtu\./ {
# jestliže první øádek obsahuje : Zapiš další vìtu. pøidej další øádek
	N
	# jestliže druhý øádek obsahuje Ano m smaž první øádek
	/Knižní démonek: Ano m./d
}

/: Dobøe, dáme se do toho\./ {
	N
	/Knižní démonek: Dobøe m./d
}

/: Dokonèi knihu\./ {
	N
	/Knižní démonek: Ano m./d
}

/: Ne, tak to ne\./ {
	N
	/Knižní démonek: Co si pøeješ m./d
}

/: Ano, smaž ji\./ {
	N
	/Knižní démonek: Smazal jsem pos/d
}

/: Smaž všechno co máš\./ {
	N
	/Knižní démonek: Vážnì m./d
}

/: Ano, smaž to\./ {
	N
	/Knižní démonek: Smazal jsem vše/d
}

# Smaž vìty, které obsahují tyto výrazy:
/\] Knižní démonek: Ano má paní/d
/\] Knižní démonek: Co si pøeješ má paní?/d
/\] Knižní démonek: Co si pøeješ mùj pane?/d
/\] Knižní démonek: Dobøe má paní, co mám dìlat teï?/d
/\] Knižní démonek: Dobøe mùj pane, co mám dìlat teï?/d
/\] Knižní démonek: Dobøe../d
/\] Knižní démonek: Je mi líto, ale víc se do knížky nevejde. Ukonèet/d
/\] Knižní démonek: Jsi si jistý má paní? Mám ho smazat?/d
/\] Knižní démonek: Jsi si jistý mùj pane? Mám ho smazat?/d
/\] Knižní démonek: Poèkejte chvilku../d
/\] Knižní démonek: Smazal jsem poslední vìtu./d
/\] Knižní démonek: Smazal jsem všechno i titulek./d
/\] Knižní démonek: Tak jsem to zapsal./d
/\] Knižní démonek: Tak titulek už mám./d
/\] Knižní démonek: Tak, a mám ji./d
/\] Knižní démonek: Tato kniha je chránìná proti úpravám, ale vy ji m/d
/\] Knižní démonek: Vážnì má paní? Mám všecièko smazat?/d
/\] Knižní démonek: Vážnì mùj pane? Mám všecièko smazat?/d
/\] Kragzug Škrábal: M.* pa.* zprávu jsem doškrábal, mám vám ji odevzd/d
/\] Kragzug Škrábal: Øeknìte mi nadpis (maximálnì 30 znakù) a kliknìt/d
/\] Kragzug Škrábal: Nadiktujte mi zprávu a kliknìte na Hotovo./d
/\] Kragzug Škrábal: Vítej m.* pa.*\. Nechte nadiktovat vzkaz? Jsem tu /d
