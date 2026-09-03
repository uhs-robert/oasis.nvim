# extras/psreadline/themes/light/1/oasis_dune_light_1.ps1
## name: Oasis Dune Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;116;75;50m"
  Comment                 = "$esc[38;2;125;111;102m"
  ContinuationPrompt      = "$esc[38;2;122;112;102m"
  Default                 = "$esc[38;2;28;28;19m"
  Emphasis                = "$esc[38;2;54;124;105m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;148;143;139m"
  Keyword                 = "$esc[38;2;122;110;29m"
  ListPrediction          = "$esc[38;2;148;143;139m"
  ListPredictionTooltip   = "$esc[38;2;148;143;139m"
  Member                  = "$esc[38;2;42;110;137m"
  Number                  = "$esc[38;2;170;87;19m"
  Operator                = "$esc[38;2;106;97;42m"
  Parameter               = "$esc[38;2;59;115;55m"
  String                  = "$esc[38;2;169;18;24m"
  Type                    = "$esc[38;2;56;113;96m"
  Variable                = "$esc[38;2;134;38;225m"
  ListPredictionSelected  = "$esc[48;2;243;218;186m" + "$esc[38;2;28;28;19m"
  Selection               = "$esc[48;2;243;218;186m" + "$esc[38;2;28;28;19m"
}