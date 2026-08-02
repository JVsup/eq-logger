#requires -Version 3
# poznamka pro editovani a pousteni v ISE: Set-ExecutionPolicy Bypass -Scope Process

######################################
# NASTAVENI - NAVOD
#
#
# POZOR - pro spravnou funkci musi byt skript v adresari logs v umisteni instalacky hry (napr. c:\nwn\logs)
#
# Pokud si chcete udelat zastupce na plose pro jednodussi spusteni, prikaz je nasledovny (prave mysitko na plochu > novy > zastupce ; nezapomente spravne zmenit cestu k instalacce nwn):
# cmd /c start powershell.exe -ExecutionPolicy Bypass -File "C:\Games\NWN\logs\parser.ps1"
#
#
# ZDE NASLEDUJI PROMENNE, KTERE MUSITE ZMENIT PRO SPRAVNOU FUNKCI!!!
#
# jmeno vasi postavy - pokud ma viceslovne jmeno, staci jen prvni slovo pripadne jeho zacatek (kdyz v nem mate diakritiku nebo jine divne znaky treba a skript by nefungoval)
$charname = "Alariel"
#
# v pripade viceslovneho jmena jej lze pokratit - zadejte sem zbytek jmena postavy, ktery nechcete v logu videt
$delname = "Erna"
#
######################################

######################################
# CO TO VLASTNE DELA
#
#
# - filtruje log hry a zobrazuje jen udaje relevantni pouze pro vasi postavu nebo systemove hru jako takovou:
# -- zraneni z/do postavy
# -- uspesne utoky z/do postavy
# -- zachranne hody
# -- kouzleni
# -- interference
# -- male hulky
# -- rozptyleni magie
# -- imka na mysl, srazeni
# -- zbyvajici body kamenky apod.
# -- hlaseni zabiti
# -- leceni
# -- pasti a zamky
# -- eq nemoci
#
# - nezobrazuje drtivou vetsinu akci cizich postav
# - nezobrazuje minuti v soubojich
#
# - informace jsou barevne rozlisene pro vetsi prehlednost
######################################

######################################
# V KODU NIZE JIZ NENI NUTNE NIC MENIT
# ...ale samozrejme pokud si chcete skript upravit k obrazu svemu, smele do toho
######################################


######################################
######################################
######################################


# FUNKCE
#
# nastaveni pozice okna
function Global:Set-ConsolePosition ($x, $y, $w, $h) {
    # Note: the DLL code below should not be indented from the left-side
    Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")] 
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int W, int H); '
    # Do the Add-Type outside of the function as repeating it in a session can cause errors
    $consoleHWND = [Console.Window]::GetConsoleWindow();
    $consoleHWND = [Console.Window]::MoveWindow($consoleHWND, $x, $y, $w, $h);
    # $consoleHWND = [Console.Window]::MoveWindow($consoleHWND,75,0,600,600);
    # $consoleHWND = [Console.Window]::MoveWindow($consoleHWND,-6,0,600,600);
}
Function Set-Position {
    Add-Type -AssemblyName System.Windows.Forms
    $Screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $width = $Screen.WorkingArea.Width   # .WorkingArea ignores the taskbar, .Bounds is whole screen
    $height = $Screen.WorkingArea.Height
    $w = $width + 13
    $h = $height + 8
    #$x = $w - [math]::Truncate($width/4)
	$x = -7
    $y = $h - 391 
    
    #Write-Host $Screen
    #Write-Host $height
    #Write-Host $width
    #Write-Host $w
    #Write-Host $h
    #Write-Host $x
    #Write-Host $y

    Set-ConsolePosition $x $y 1080 390

    $MyBuffer = $Host.UI.RawUI.BufferSize
    $MyWindow = $Host.UI.RawUI.WindowSize
    $MyBuffer.Height = 3000
    #"`nWindowSize $($MyWindow.Width)x$($MyWindow.Height) (Buffer $($MyBuffer.Width)x$($MyBuffer.Height))"
    #"Position : Left:$x Top:$y Width:$w Height:$h`n"

    #Write-Host $MyBuffer
    #Write-Host $MyWindow
    }
#
# cekani na proces
function Wait-ForProcess {
    param
    (
        $Name = 'nwmain',

        [Switch]
        $IgnoreAlreadyRunningProcesses
    )

    if ($IgnoreAlreadyRunningProcesses)
    {
        $NumberOfProcesses = (Get-Process -Name $Name -ErrorAction SilentlyContinue).Count
    }
    else
    {
        $NumberOfProcesses = 0
    }


    Write-Host "Waiting for $Name" -NoNewline
    while ( (Get-Process -Name $Name -ErrorAction SilentlyContinue).Count -eq $NumberOfProcesses )
    {
        Write-Host '.' -NoNewline
        Start-Sleep -Milliseconds 400
    }

    Write-Host ''
}
#
# barvicky v konzoli
Function Out-HostColored {
<#
.SYNOPSIS
Colors portions of the default host output that match given patterns.

.DESCRIPTION
Colors portions of the default-formatted host output based on either
regular expressions or a literal substrings, assuming the host is a console or
supports colored output using console colors.

Matching is restricted to a single line at a time, but coloring multiple
matches on a given line is supported.

Two basic syntax forms are supported:

  * Single-color, via -Pattern, -ForegroundColor and -BackgroundColor

  * Multi-color (color per pattern), via a hashtable (dictionary) passed to
    -PatternColorMap.

Note: Since output is sent to the host rather than the pipeline, you cannot
      chain calls to this function.

.PARAMETER Pattern
One or more search patterns specifying what parts of the formatted 
representations of the input objects should be colored.

 * By default, these patterns are interpreted as regular expressions.

 * If -SimpleMatch is also specified, the patterns are interpreted as literal
   substrings.

.PARAMETER ForegroundColor
The foreground color to use for the matching portions.
Defaults to yellow.

.PARAMETER BackgroundColor
The optional background color to use for the matching portions.

.PARAMETER PatternColorMap
A hashtable (dictionary) with one or more entries in the following format:

  <pattern-or-pattern-array> = <color-spec>

<pattern-or-pattern-array> is either a single string or an array of strings
specifying the regex pattern(s) or literal substring(s) (with -SimpleMatch)
to match.
Note: If you're specifying an array in a hashtable literal, you must enclose it
      in (...), and the individual patterns must all be quoted; e.g.:
        ('foo', 'bar')

<color-spec> is a string that contains either a foreground [ConsoleColor] 
color alone (e.g. 'red'), a combination with a background color separated by ","
(e.g., 'red,white') or just a background color (e.g, ',white').

See the examples for a complete example.

.PARAMETER CaseSensitive
Matches the patterns case-sensitively.
By default, matching is case-insensitive.

.PARAMETER WholeLine
Specifies that the entire line containing a match should be colored,
not just the matching portion.

.PARAMETER SimpleMatch
Interprets the -Pattern argument(s) as a literal substrings to match rather
than as regular expressions.

.PARAMETER InputObject
The input object(s) whose formatted representations to color selectively.
Typically provided via the pipeline.

.EXAMPLE
'A fool and his money', 'foo bar' | Out-HostColored foo

Prints the substring 'foo' in yellow in the two resulting output lines.

.EXAMPLE
Get-Date | Out-HostColored '\p{L}+' red white

Outputs the current date with all tokens composed of letters (p{L}) only in red
on a white background.

.EXAMPLE
Get-Date | Out-HostColored @{ '\p{L}+' = 'red,white' }

Same as the previous example, only via the dictionary-based -PatternColorMap
parameter (implied).

.EXAMPLE
'It ain''t easy being green.' | Out-HostColored @{ ('easy', 'green') = 'green'; '\bbe.+?\b' = 'black,yellow' }

Prints the words 'easy' and 'green' in green, and the word 'being' in black on yellow.
Note the need to enclose pattern array 'easy', 'green' in (...), which also necessitates
quoting its element.

.EXAMPLE
Get-ChildItem | select Name | Out-HostColored -WholeLine -SimpleMatch .txt

Highlight all text file names in green.

.EXAMPLE
'apples', 'kiwi', 'pears' | Out-HostColored '^a', 's$' blue

Highlight all "A"s at the beginning and "S"s at the end of lines in blue.
#>

  # === IMPORTANT:
  #   * At least for now, we remain PSv2-COMPATIBLE.
  #   * Thus: 
  #     * no `[ordered]`, `::new()`, `[pscustomobject]`, ...
  #     * No implicit Boolean properties in [CmdletBinding()] and [Parameter()] attributes (`Mandatory = $true` instead of just `Mandatory`)
  # ===

  [CmdletBinding(DefaultParameterSetName = 'SingleColor')]
  param(
    [Parameter(ParameterSetName = 'SingleColor', Position = 0, Mandatory = $True)] [string[]] $Pattern,
    [Parameter(ParameterSetName = 'SingleColor', Position = 1)] [ConsoleColor] $ForegroundColor = [ConsoleColor]::Yellow,
    [Parameter(ParameterSetName = 'SingleColor', Position = 2)] [ConsoleColor] $BackgroundColor,
    [Parameter(ParameterSetName = 'PerPatternColor', Position = 0, Mandatory = $True)] [System.Collections.IDictionary] $PatternColorMap,
    [Parameter(ValueFromPipeline = $True)] $InputObject,
    [switch] $WholeLine,
    [switch] $SimpleMatch,
    [switch] $CaseSensitive
  )

  begin {

    Set-StrictMode -Version 1

    if ($PSCmdlet.ParameterSetName -eq 'SingleColor') {

      # Translate the indiv. arguments into the dictionary format suppoorted
      # by -PatternColorMap, so we can process $PatternColorMap uniformly below.
      $PatternColorMap = @{
        $Pattern = $ForegroundColor, $BackgroundColor
      }

    } 
    # Otherwise: $PSCmdlet.ParameterSetName -eq 'PerPatternColor', i.e. a dictionary
    #            mapping patterns to colors was direclty passed in $PatternColorMap

    try {

      # The options for the [regex] instances to create.
      # We precompile them for better performance with many input objects.
      [System.Text.RegularExpressions.RegexOptions] $reOpts = 
      if ($CaseSensitive) { 'Compiled, ExplicitCapture' } 
      else { 'Compiled, ExplicitCapture, IgnoreCase' }

      # Transform the dictionary:
      #  * Keys: Consolidate multiple patterns into a single one with alternation and
      #          construct a [regex] instance from it.
      #  * Values: Transform the "[foregroundColor],[backgroundColor]" strings into an arguments
      #            hashtable that can be used for splatting with Write-Host.
      $map = @{ }
      foreach ($entry in $PatternColorMap.GetEnumerator()) {

        # Create a Write-Host color-arguments hashtable for splatting.
        if ($entry.Value -is [array]) {
          $fg, $bg = $entry.Value # [ConsoleColor[]], from the $PSCmdlet.ParameterSetName -eq 'SingleColor' case.
        }
        else {
          $fg, $bg = $entry.Value -split ','
        }
        $colorArgs = @{ }
        if ($fg) { $colorArgs['ForegroundColor'] = [ConsoleColor] $fg }
        if ($bg) { $colorArgs['BackgroundColor'] = [ConsoleColor] $bg }

        # Consolidate the patterns into a single pattern with alternation ('|'),
        # escape the patterns if -SimpleMatch was passsed.
        $re = New-Object regex -Args `
          $(if ($SimpleMatch) {
              ($entry.Key | ForEach-Object { [regex]::Escape($_) }) -join '|'
            } 
            else { 
              ($entry.Key | ForEach-Object { '({0})' -f $_ }) -join '|'
            }),
          $reOpts

        # Add the tansformed entry.
        $map[$re] = $colorArgs

      }
    } 
    catch { throw }

    # Construct the arguments to pass to Out-String.
    $htArgs = @{ Stream = $True }
    if ($PSBoundParameters.ContainsKey('InputObject')) { # !! Do not use `$null -eq $InputObject`, because PSv2 doesn't create this variable if the parameter wasn't bound.
      $htArgs.InputObject = $InputObject
    }

    # Construct the script block that is used in the steppable pipeline created
    # further below.
    $scriptCmd = {

      # Format the input objects with Out-String and output the results line
      # by line, then look for matches and color them.
      & $ExecutionContext.InvokeCommand.GetCommand('Microsoft.PowerShell.Utility\Out-String', 'Cmdlet') @htArgs | ForEach-Object {

        # Match the input line against all regexes and collect the results.
        $matchInfos = :patternLoop foreach ($entry in $map.GetEnumerator()) {
          foreach ($m in $entry.Key.Matches($_)) {
            @{ Index = $m.Index; Text = $m.Value; ColorArgs = $entry.Value }
            if ($WholeLine) { break patternLoop }
          }
        }
        
        # # Activate this for debugging.
        # $matchInfos | Sort-Object { $_.Index } | Out-String | Write-Verbose -vb
      
        if (-not $matchInfos) {
          # No match found - output uncolored.
          Write-Host -NoNewline $_
        }
        elseif ($WholeLine) {
          # Whole line should be colored: Use the first match's color
          $colorArgs = $matchInfos.ColorArgs
          Write-Host -NoNewline @colorArgs $_
        }
        else {
          # Parts of the line must be colored:
          # Process the matches in ascending order of start position.    
          $offset = 0
          foreach ($mi in $matchInfos | Sort-Object { $_.Index }) { # !! Use of a script-block parameter is REQUIRED in WinPSv5.1-, because hashtable entries cannot be referred to like properties, unlinke in PSv7+
            if ($mi.Index -lt $offset) {
              # Ignore subsequent matches that overlap with previous ones whose colored output was already produced.
              continue 
            }
            elseif ($offset -lt $mi.Index) {
              # Output the part *before* the match uncolored.
              Write-Host -NoNewline $_.Substring($offset, $mi.Index - $offset)
            }
            $offset = $mi.Index + $mi.Text.Length
            # Output the match at hand colored.
            $colorArgs = $mi.ColorArgs
            Write-Host -NoNewline @colorArgs $mi.Text
          }
          # Print any remaining part of the line uncolored.
          if ($offset -lt $_.Length) {
            Write-Host -NoNewline $_.Substring($offset)
          }
        }
        Write-Host '' # Terminate the current output line with a newline - this also serves to reset the console's colors on Unix.

      }
    }

    # Create the script block as a *steppable pipeline*, which enables
    # to perform regular streaming pipeline processing, without having to collect
    # everything in memory first.
    $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
    $steppablePipeline.Begin($PSCmdlet)

  } # begin

  process
  {
    $steppablePipeline.Process($_)
  }

  end
  {
    $steppablePipeline.End()
  }

}


# INIT OKNA A BUFFERU
$Host.UI.RawUI.WindowTitle = "Parser NWN logu"
$host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.Size(150,3000)
[system.console]::WindowWidth = 150
[system.console]::WindowHeight = 30
Set-Position


# POMOCNE PROMENNE
$cesta = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$logfile = "$cesta\nwclientLog1.txt"
$extfile = "$cesta\parser.log"
$date = Get-Date -UFormat %d-%m
$utokzasah1 = "$charname.*útočí.*zásah"
$utokzasah2 = "útočí.*$charname.*zásah"
$zranil1 = "$charname.*zranil"
$zranil2 = "zranil.*$charname"
$touch1 = "$charname.*zkouší.*zásah"
$touch2 = "zkouší.*$charname.*zásah"
$touch3 = "$charname.*zkouší.*odolal"
$touch4 = "zkouší.*$charname.*odolal"
$song = "$charname zpívá.$"
$nemoc1 = "Ulevilo se ti a cítíš se lépe.$"
$nemoc2 = "Je ti zle od žaludku a bolí tě hlava.$"
$nemoc3 = "$charname.*omdlel"
$nemoc4 = "Strašně tě svědí hlava a chceš se všude drbat.$"
$nemoc5 = "Začínáš se nekontrolovatelně třást a chvět."
$nemoc6 = "Bolí tě hlava a je ti malátně a špatně od žaludku.$"
$nemoc7 = "Je ti nesmírně zle od žaludku.$"
$nemoc8 = "\] Necítíš se dobře a bolí tě v krku.$"
$odpocinek = "\] Konec odpočinku$"
$connect1 = "se připojil jako"
$connect2 = "se odpojil jako"
$use1 = "Tuto dovednost nemůžeš použít následujících"
$pvp1 = "tě teď nemá v oblibě!$"
$item1 = "Ztracený předmět:"
$item2 = "Získaný předmět:"
$make1 = "Výroba.*se povedla"
$make2 = "Výroba.*se nepovedla"

# BEZI NWMAIN?
#Wait-ForProcess -Name nwmain
Write-Host 'NALEZENO!'
Write-Host 'Nwmain bezi, poustim cteni logu za 10 vterin...'
#Start-Sleep -Seconds 10

cls
Set-Position
Write-Host 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
Write-Host 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
Write-Host 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'


# SAMOTNE VYCITANI
Get-Content $logfile -Wait |
  % {$_.replace("[CHAT WINDOW TEXT] ","")} |
  % {$_.replace("zkouší","zkouší ")} |
  % {$_.replace("$delname","")} |
  % {$_ -replace "\[...........", "[$date "} |
  % {$_ -replace "\s\s+", " "} |
  % {$_ -replace ".*používá zvláštní schopnost předmětu.$", ""} |
  % {$_ -replace ".*Používá se brnění.štít..*", ""} |
  % {$_ -replace ".*několik předmětů. které dávají bonus k.*", ""} |
  % {$_ -replace ".*Zbraň se používá jako .* zbraň.*", ""} |
  % {$_ -replace ".*Už ti ho zbývá jenom \d\d+", ""} |
  % {$_ -replace ".*Do toho všeho je ti strašně zle.$*", "[UMRELI TE HAHA] A TED MAS POSMRTKY HOHOHO!"} |
  % {$_ -replace "\] Cítíš se divně.$", "] Cítíš se divně - MÁŠ NEMOC!"} |
  Select-String -Pattern 'používá','NEMOC',': Soustředění :',': Výsměch :','Otevírání zámků','Odstranění pasti','kritická chyba','Spustil jsi past.$','POSMRTKY','kouzlo.*selhalo','vyléčeno','zabil','zbývá','Záchranný','záchranný','na vůli','sesílá ','Imunita na mysl','Imunita na sražení','odolat kouzlu','vytahuje malou hůlku','Rozptyl kouzla ','Zinterferovalo ti', 'prudk', 'oškliv', 'Získané zkušenosti: \d\d',$utokzasah1,$utokzasah2,$zranil1,$zranil2,$touch1,$touch2,$touch3,$touch4,$song,$nemoc1,$nemoc2,$nemoc3,$nemoc4,$nemoc5,$nemoc6,$nemoc7,$nemoc8,$odpocinek,$connect1,$connect2,$use1,$pvp1,$item1,$item2,$make1,$make2 |
  Tee-Object -Append -FilePath $extfile |
  Out-HostColored @{ 
    "^.*$charname.*zkouší.*zásah.*" = 'green'
    "^.*zkouší.*$charname.*zásah.*" = 'white,red'
    "^.*$charname.*zkouší.*odolal.*" = 'green,darkgray'
    "^.*zkouší.*$charname.*odolal.*" = 'red'
    "^.*$charname.*útočí.*" = 'green'
    "^.*útočí.*$charname.*" = 'red'
    "^.*$charname.*\d\d\d bodů zbývá.*" = 'yellow'
    "^.*$charname.*\s[3-9]\d bodů zbývá.*" = 'yellow'
    "^.*$charname.*\s[1-2][0-9] bodů zbývá.*" = 'black,yellow'
    "^(?!.*$charname).*bodů zbývá.*" = 'white,darkred'
    "^.*$charname.*\s[0-9] bodů zbývá.*" = 'black,yellow' 
    "^.*$charname.*\s\d\d úrovní zbývá.*" = 'black,yellow'
    "^.*$charname.*\s[0-9] úrovní zbývá.*" = 'black,yellow'
    "^(?!.*$charname).*úrovní zbývá.*" = 'white,darkred'
    "^.*] $charname.*sesílá.*" = 'white'
    "^(?!.*$charname).*sesílá.*" = 'red,white'
    "^.*kouzlo zrušeno.*" = 'black,magenta'
    '^.*] Rozptyl kouzla.*$' = 'black,magenta'
    '^.*hůlku.*' = 'black,magenta'
    '^.*Zinterferovalo.*' = 'black,magenta'
    "^(?!.*$charname).*Imunita.*" = 'yellow,red'
    '^.*Kouzlo.*selhalo.*' = 'yellow,red'
    "^.*$charname.*neúspěch.*" = 'white,red'
    "^(?!.*$charname).* \*úspěch.*" = 'white,red'
    "^.*$charname.*odolal kouzlu.*" = 'cyan'
    "^(?!.*$charname).*odolal kouzlu.*" = 'cyan,red'
    "^.*$charname.*kouzlo pohlceno.*" = 'cyan'
    "^(?!.*$charname).*kouzlo pohlceno.*" = 'cyan,red'
    "^.*$charname.*zabil.*" = 'black,green'
    "^.*zabil.*$charname.*" = 'black,red'
    "^(?!.*$charname).*zabil.*" = 'gray'
	"^(?!.*$charname).*Získané zkušenosti:.*" = 'gray'
    ".*Vyléčeno.*" = 'yellow'
    ".*POSMRTKY.*" = 'red,black'
    ".*jsi past.*" = 'red'
    "^.*$charname.*nemožný.*" = 'red,black'
    ".*kritická chyba.*" = 'red,black'
    "^(?!.*$charname).*zpívá.$" = 'magenta'
    ".*střelivo.*" = 'black,yellow'
	".*NEMOC.*" = 'black,red'
	".*prudk.*" = 'black,red'
	".*oškliv.*" = 'black,red'
    ".*omdlel.*" = 'black,red'
    ".*svědí.*" = 'red'
    ".*nekontrolovatelně.*" = 'red'
    ".*od žaludku.*" = 'red'
    ".*necítíš.*" = 'red'
    ".*ulevilo se ti.*" = 'green'
	".*\] Konec odpočinku.*" = 'black,gray'
    ".*$charname.*používá.*" = 'gray'
	"^(?!.*$charname).*používá.*" = 'red'
    ".*připojil.*" = 'yellow'
    ".*odpojil.*" = 'yellow'
    ".*použít.*" = 'red'
	".*oblibě.*" = 'black,red'
    ".*Ztracený předmět:.*" = 'red'
    ".*Získaný předmět:.*" = 'green'
    ".*Výroba.*se povedla.*" = 'green'
    ".*Výroba.*se nepovedla.*" = 'red'
  }