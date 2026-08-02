# Obchod.sed 1.0
# Roma

:loop_obchod
# pokud najde *ný pøedmìt
/\].*n. p.edm.t:/ {
# nahradí ný pøedmìt: za ný_loop_pøedmet:
	s/n. p.edm.t:/n._loop_p.edm.t:/g
# pøidá další øádek
	N
# pokud na pøidaném øádku je *.ný pøedmìt:
	/\].*n. p.edm.t:/ {
# odebere odøádkování
		s/\n/;/g
# èas a text pøidaný/odebraný pøedmìt nahradí za +/-
		s/\[... ... .. ..:..:..\] Z.skan. p.edm.t:/ +/g
		s/\[... ... .. ..:..:..\] Ztracen. p.edm.t:/ -/g
		s/n._loop_p.edm.t:/n. p.edm.t:/g
# znovu skoèí na zaèátek skriptu... Otestuje jestli další øádek obsahuje text *ný pøedmìt
		/n. p.edm.t:/b loop_obchod
# pokud další øádek neobsahuje text *ný pøedmìt zobrazí výstup 
		P
# smaže první øádek
		D
	}
s/ Z.skan._loop_p.edm.t:/ Obchod: +/g
s/ Ztracen._loop_p.edm.t:/ Obchod: -/g
}

/\] \*stahuje z kùže\*/ {
# jestliže první øádek obsahuje *stahuje z kùže* pøidej další øádek
	N
	/: \*stahuje z kùže\*/ {
	# jestliže druhý øádek obsahuje *stahuje z kùže* smaž první øádek
		D
	}	
}

/\] \*porcuje maso\*/ {
	N
	/: \*porcuje maso\*/ {
		D
	}	
}

/\] \*hledá houby\*/ {
	N
	/: \*hledá houby\*/ {
		D
	}	
}

/\] \*chytá ryby\*/ {
	N
	/: \*chytá ryby\*/ {
		D
	}	
}

/\] \*sbírá jahody\*/ {
	N
	/: \*sbírá jahody\*/ {
		D
	}	
}

/\] \*sbírá maliny\*/ {
	N
	/: \*sbírá maliny\*/ {
		D
	}	
}

/\] \*hledá mušle\*/ {
	N
	/: \*hledá mušle\*/ {
		D
	}	
}

/\] \*rýžuje\*/ {
	N
	/: \*rýžuje\*/ {
		D
	}	
}

