@ECHO OFF
:: Samostatna uprava logu pro Equilibrii 1.0
:: Roma

TITLE Equilibrie - Uprava logu

::Test pøetažení
SET "drag=%~1"
IF "%drag%"=="" GOTO vstupni_soubor_spatnynazev
SET "vstupni_soubor=%~nx1"
GOTO vstupni_soubor_nalezen

::Vstupní soubor
:vstupni_soubor_spatnynazev
ECHO Zadej nazev souboru ktery chcete upravit.
SET /p vstupni_soubor= Zadej: 
SET "vstupni_soubor=%vstupni_soubor:"=%"
IF EXIST "%vstupni_soubor%" GOTO vstupni_soubor_nalezen
CLS
ECHO Soubor nebyl nalezen, zadejte prosim znovu
GOTO vstupni_soubor_spatnynazev

::Výstupní soubor
:vstupni_soubor_nalezen
ECHO.
ECHO Zadej nazev souboru pro ulozeni upraveneho souboru "%vstupni_soubor%".
set /p vystupni_soubor= Zadej: 
IF EXIST "%~dp1%vystupni_soubor%" ECHO Soubor "%vystupni_soubor%" jiz existuje, zadejte prosim znovu &GOTO vstupni_soubor_nalezen
ECHO.

::Vše OK, mùžeme zaèít

ECHO.
ECHO Vyckejte prosim, nemelo by to trvat dele nez nekolik desitek sekund.
ECHO V zavislosti na velikosti souboru a vykonu Vaseho pocitace.
ECHO.
CD %~dp0
sed "/^$/d" "%~dp1%vstupni_soubor%" >"log.txt"

ECHO./ CCCCCC/d >Porovnani.sed
ECHO./^^$/d >>Porovnani.sed
ECHO./^^ $/d >>Porovnani.sed

ECHO.s/^^\[CHAT WINDOW TEXT\] //g >>Porovnani.sed
ECHO./\[/!s/^^/ffffff/g >>Porovnani.sed
ECHO./: \[CHAT WINDOW TEXT\] \[/s/: \[CHAT WINDOW TEXT\] \[/: [/g >>Porovnani.sed
ECHO./Nástìnka pro vzkazy: Vzkazy na nástìnce:/!s/\[... ... .. ..:..:..] Nástìnka pro vzkazy:/ffffffNástìnka:/g >>Porovnani.sed
ECHO./  /s/  / /g >>Porovnani.sed
ECHO./  /s/  / /g >>Porovnani.sed
IF EXIST Odebrani_z_logu.sed TYPE Odebrani_z_logu.sed >>Porovnani.sed

sed -f "Porovnani.sed" "log.txt" >"log3.txt"
ECHO.
ECHO Uz to skoro bude /.-)
sed ":a; $!N;s/\nffffff/; /;ta;P;D" "log3.txt" >"log2.txt"
uniq -s 21 "log2.txt" >"log.txt"
sed -f "Pisari.sed" "log.txt" >"log2.txt"
sed -f "Obchod.sed" "log2.txt" >"log3.txt"
sed "{ /^^$/s/^^$/^$/g; /^$/d; /_poznamka./d; }" "log3.txt" >"log2.txt"
uniq -s 21 "log2.txt" >"log.txt"
sed "{ /^^$/s/^^$/^$/g; /^$/d; /;\[/s/;\[/\n[/g; }" "log.txt" >"log3.txt"



TYPE log3.txt >>"%~dp1%vystupni_soubor%"
DEL log.txt
DEL log2.txt
DEL log3.txt
DEL Porovnani.sed
ECHO.
ECHO.
ECHO.
ECHO Hotovo.
ECHO Po stisku klavesy se okno zavre.
PAUSE
EXIT
