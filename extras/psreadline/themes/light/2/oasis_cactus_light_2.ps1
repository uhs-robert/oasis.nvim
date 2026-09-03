# extras/psreadline/themes/light/2/oasis_cactus_light_2.ps1
## name: Oasis Cactus Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;112;72;49m"
  Comment                 = "$esc[38;2;92;116;94m"
  ContinuationPrompt      = "$esc[38;2;100;113;103m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;163;5;5m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;134;141;135m"
  Keyword                 = "$esc[38;2;68;116;71m"
  ListPrediction          = "$esc[38;2;134;141;135m"
  ListPredictionTooltip   = "$esc[38;2;134;141;135m"
  Member                  = "$esc[38;2;41;106;132m"
  Number                  = "$esc[38;2;164;84;18m"
  Operator                = "$esc[38;2;59;103;61m"
  Parameter               = "$esc[38;2;128;93;18m"
  String                  = "$esc[38;2;163;18;24m"
  Type                    = "$esc[38;2;54;109;93m"
  Variable                = "$esc[38;2;129;32;222m"
  ListPredictionSelected  = "$esc[48;2;189;225;200m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;189;225;200m" + "$esc[38;2;24;24;17m"
}