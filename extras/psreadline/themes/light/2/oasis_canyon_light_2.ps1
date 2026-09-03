# extras/psreadline/themes/light/2/oasis_canyon_light_2.ps1
## name: Oasis Canyon Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;78;71;26m"
  Comment                 = "$esc[38;2;125;91;76m"
  ContinuationPrompt      = "$esc[38;2;114;95;85m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;163;5;5m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;133;126;122m"
  Keyword                 = "$esc[38;2;167;59;29m"
  ListPrediction          = "$esc[38;2;133;126;122m"
  ListPredictionTooltip   = "$esc[38;2;133;126;122m"
  Member                  = "$esc[38;2;36;95;118m"
  Number                  = "$esc[38;2;148;75;16m"
  Operator                = "$esc[38;2;146;51;25m"
  Parameter               = "$esc[38;2;51;99;47m"
  String                  = "$esc[38;2;143;16;21m"
  Type                    = "$esc[38;2;49;97;83m"
  Variable                = "$esc[38;2;115;28;198m"
  ListPredictionSelected  = "$esc[48;2;228;187;152m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;228;187;152m" + "$esc[38;2;24;24;17m"
}