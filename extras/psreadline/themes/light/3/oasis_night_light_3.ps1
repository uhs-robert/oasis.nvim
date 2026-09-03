# extras/psreadline/themes/light/3/oasis_night_light_3.ps1
## name: Oasis Night Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;98;63;43m"
  Comment                 = "$esc[38;2;87;101;119m"
  ContinuationPrompt      = "$esc[38;2;92;101;110m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;155;3;3m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;124;129;134m"
  Keyword                 = "$esc[38;2;104;96;42m"
  ListPrediction          = "$esc[38;2;124;129;134m"
  ListPredictionTooltip   = "$esc[38;2;124;129;134m"
  Member                  = "$esc[38;2;36;95;121m"
  Number                  = "$esc[38;2;148;76;16m"
  Operator                = "$esc[38;2;89;85;41m"
  Parameter               = "$esc[38;2;52;100;47m"
  String                  = "$esc[38;2;144;16;20m"
  Type                    = "$esc[38;2;48;98;84m"
  Variable                = "$esc[38;2;115;29;200m"
  ListPredictionSelected  = "$esc[48;2;158;194;235m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;158;194;235m" + "$esc[38;2;24;24;17m"
}