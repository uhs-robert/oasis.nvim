# extras/psreadline/themes/light/2/oasis_scorpion_light_2.ps1
## name: Oasis Scorpion Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;97;63;42m"
  Comment                 = "$esc[38;2;118;93;87m"
  ContinuationPrompt      = "$esc[38;2;110;96;93m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;126;118;42m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;133;126;122m"
  Keyword                 = "$esc[38;2;104;96;42m"
  ListPrediction          = "$esc[38;2;133;126;122m"
  ListPredictionTooltip   = "$esc[38;2;133;126;122m"
  Member                  = "$esc[38;2;36;95;118m"
  Number                  = "$esc[38;2;148;75;16m"
  Operator                = "$esc[38;2;89;84;40m"
  Parameter               = "$esc[38;2;52;99;47m"
  String                  = "$esc[38;2;143;16;21m"
  Type                    = "$esc[38;2;49;97;83m"
  Variable                = "$esc[38;2;115;28;198m"
  ListPredictionSelected  = "$esc[48;2;236;175;157m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;236;175;157m" + "$esc[38;2;24;24;17m"
}