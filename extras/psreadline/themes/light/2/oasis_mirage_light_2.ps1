# extras/psreadline/themes/light/2/oasis_mirage_light_2.ps1
## name: Oasis Mirage Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;113;72;49m"
  Comment                 = "$esc[38;2;72;120;111m"
  ContinuationPrompt      = "$esc[38;2;100;114;113m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;76;5;163m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;134;142;142m"
  Keyword                 = "$esc[38;2;55;117;100m"
  ListPrediction          = "$esc[38;2;134;142;142m"
  ListPredictionTooltip   = "$esc[38;2;134;142;142m"
  Member                  = "$esc[38;2;41;107;133m"
  Number                  = "$esc[38;2;166;84;18m"
  Operator                = "$esc[38;2;49;103;87m"
  Parameter               = "$esc[38;2;58;112;53m"
  String                  = "$esc[38;2;164;18;24m"
  Type                    = "$esc[38;2;111;100;29m"
  Variable                = "$esc[38;2;130;32;223m"
  ListPredictionSelected  = "$esc[48;2;181;231;226m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;181;231;226m" + "$esc[38;2;24;24;17m"
}