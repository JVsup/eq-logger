@echo off
:: launcher a logger a screenshot converter a blablabla pro nwn EQ
:: originalni kod sepsali roma, alcatraz
:: upravil placidity

:: pouziti na vlastni nebezpeci, byli jste varovani
:: a pokud vam tenhle skript neco rozbije, stezujte si na lamparne

:: vysledkem logovani jsou dva soubory
:: zaloha_equilibrie.log    - inkrementalni plny log  - kopie toho, co zalogovalo nwn
:: zaloha_equilibrie_cl.log - inkrementalni cisty log - plny log ocisteny SEDem od vetsiny blbosti

:: konvertovane screenshoty a zabalene tga jsou ve svem vlastnim adresari ve screenshots
:: pokud zalohy tga nechcete (baleni muze trvat), staci zakomentovat radky (viz komenty v kodu)

:: dale umi discord rich presence (custom status na discordu, trochu hack)
:: navod na nastaveni nize, logo eq je v adresari s aplikaci abyste nemuseli vytvaret
:: https://www.reddit.com/r/discordapp/comments/a2c2un/how_to_setup_a_custom_discord_rich_presence_for/

:: a pote je jeste prilozeny parser logu, ktery jede v externim okne jako powershell skript
:: volitelne jej muzete po skonceni hry nechat automaticky zavrit

:: upraveno pro EE verzi
:: je potreba dopsat do vars nize spravnou cestu k instalacce hry (predvyplnena vam skoro urcite fungovat nebude)
:: a oproti Diamondu se launcher a vsechny dalsi uzivatelske soubory musi ulozit do Dokumenty/Neverwinter Nights
:: do adresare se hrou nic nenahravejte !!!

::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: nastaveni jednotlivych funkci
:: 0 = vypnuto
:: 1 = zapnuto
SET /A var_discord = 0
SET /A var_parser = 0
SET /A var_parser_kill = 0
SET /A var_log = 1
SET /A var_screenshot = 1
SET var_path="C:\Games\Steam\steamapps\common\Neverwinter Nights\bin\win32"

::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
::xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

:: minimalizace okna
if not "%minimized%"=="" goto :minimized
set minimized=true
start /min cmd /C "%~dpnx0"
goto :EOF
:minimized

:: barvy a velikost okna
title Equilibrie Launcher
color 0c
mode con:cols=95 lines=10

:: casove hlavicky do logu
if %var_log%==0 goto jump1
echo ============================ >>logs\zaloha_equilibrie.log
echo START %date% %time%>>logs\zaloha_equilibrie.log
echo ============================ >>logs\zaloha_equilibrie.log
echo ============================ >>logs\zaloha_equilibrie_cl.log
echo START %date% %time%>>logs\zaloha_equilibrie_cl.log
echo ============================ >>logs\zaloha_equilibrie_cl.log
:jump1

:: flush dns cache
ipconfig /flushdns

:: discord rich presence
if %var_discord%==0 goto jump2
CD %~dp0/EasyRP-windows
start /b easyrp.exe
CD %~dp0/
:jump2

:: parser
if %var_parser%==0 goto jump3
start powershell.exe -ExecutionPolicy Bypass -File "%~dp0\logs\parser.ps1"
:jump3

:: pusteni nwn
cd %var_path%
start nwmain.exe +connect server.equilibrie.cz:5121

cls
echo.
echo ^> Nezavirejte toto okno! Po vypnuti NWN se proces ukonci sam.
echo.


:: stopka/loop pro kontrolu ze nwn stale bezi
SETLOCAL EnableExtensions
set EXE=nwmain.exe
:FOUND
timeout /t 1 /nobreak > NUL
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% goto FOUND

:: zabijeni aplikaci po skonceni hry
taskkill /f /IM easyrp.exe
if %var_parser_kill%==0 goto jump4
taskkill /f /IM powershell.exe
:jump4

:: kopirovani a cisteni logu

CD %~dp0/

if %var_log%==0 goto jump5
type logs\nwclientlog1.txt >> logs\zaloha_equilibrie.log
echo ============================ >>logs\zaloha_equilibrie.log
echo KONEC %date% %time% >>logs\zaloha_equilibrie.log
echo ============================ >>logs\zaloha_equilibrie.log

type logs\nwclientlog1.txt >> logs\sed_temp.log 

cls
ECHO.
echo ^> Konvertuji se logy - nezavirejte okno a vyckejte...
CD %~dp0/logs/
sed "/^$/d" "%~dp1sed_temp.log" >"log.txt"
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
sed ":a; $!N;s/\nffffff/; /;ta;P;D" "log3.txt" >"log2.txt"
uniq -s 21 "log2.txt" >"log.txt"
sed -f "Pisari.sed" "log.txt" >"log2.txt"
sed -f "Obchod.sed" "log2.txt" >"log3.txt"
sed "{ /^^$/s/^^$/^$/g; /^$/d; /_poznamka./d; }" "log3.txt" >"log2.txt"
uniq -s 21 "log2.txt" >"log.txt"
sed "{ /^^$/s/^^$/^$/g; /^$/d; /;\[/s/;\[/\n[/g; }" "log.txt" >"log3.txt"

TYPE log3.txt >>"%~dp1zaloha_equilibrie_cl.log"
echo ============================ >>zaloha_equilibrie_cl.log
echo KONEC %date% %time% >>zaloha_equilibrie_cl.log
echo ============================ >>zaloha_equilibrie_cl.log

DEL log.txt
DEL log2.txt
DEL log3.txt
DEL sed_temp.log 
DEL Porovnani.sed
:jump5

:: kopirovani a baleni obrazku
:: pokud nechcete mit zalohy tga, zakomentujte "7za..." a "move *.7z..." radky

if %var_screenshot%==0 goto jump6
SET "xdate="
FOR /F "delims=" %%I IN ('powershell.exe -NoLogo -NoProfile -NonInteractive -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') DO SET "xdate=%%I"
if not defined xdate (
    echo.
    echo ^> CHYBA: Nepodarilo se zjistit datum a cas. Screenshoty zustaly nezmenene.
    EXIT /B 1
)
cls
ECHO.
echo ^> Konvertuji se screenshoty - nezavirejte okno a vyckejte...

CD /D "%~dp0screenshots"
if not exist *.tga goto end
if not exist "%xdate%\" md "%xdate%"
if not exist "%xdate%\" (
    echo.
    echo ^> CHYBA: Nepodarilo se vytvorit adresar "%xdate%". Screenshoty zustaly nezmenene.
    EXIT /B 1
)
gm mogrify -format jpg *.tga
7za a -r "%xdate%.7z" *.tga >nul
move *.jpg "%~dp0screenshots\%xdate%"
move "%xdate%.7z" "%~dp0screenshots\%xdate%"
del /F /Q *.tga
:jump6
:end
echo.
echo ^> Vse je hotovo, okno muzete zavrit...

EXIT
