# extras/psreadline/themes/light/5/oasis_dune_light_5.ps1
## name: Oasis Dune Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;97;63;42m"
  Comment                 = "$esc[38;2;109;97;89m"
  ContinuationPrompt      = "$esc[38;2;106;98;89m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;39;98;82m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;132;126;121m"
  Keyword                 = "$esc[38;2;105;95;26m"
  ListPrediction          = "$esc[38;2;132;126;121m"
  ListPredictionTooltip   = "$esc[38;2;132;126;121m"
  Member                  = "$esc[38;2;35;95;119m"
  Number                  = "$esc[38;2;148;75;16m"
  Operator                = "$esc[38;2;90;83;36m"
  Parameter               = "$esc[38;2;51;99;47m"
  String                  = "$esc[38;2;143;15;21m"
  Type                    = "$esc[38;2;49;97;83m"
  Variable                = "$esc[38;2;115;28;198m"
  ListPredictionSelected  = "$esc[48;2;232;194;135m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;232;194;135m" + "$esc[38;2;24;24;17m"
}