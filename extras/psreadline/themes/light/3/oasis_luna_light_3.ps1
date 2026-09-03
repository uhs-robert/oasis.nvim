# extras/psreadline/themes/light/3/oasis_luna_light_3.ps1
## name: Oasis Luna Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;100;65;43m"
  Comment                 = "$esc[38;2;105;95;141m"
  ContinuationPrompt      = "$esc[38;2;102;99;118m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;21;110;137m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;130;128;138m"
  Keyword                 = "$esc[38;2;106;98;42m"
  ListPrediction          = "$esc[38;2;130;128;138m"
  ListPredictionTooltip   = "$esc[38;2;130;128;138m"
  Member                  = "$esc[38;2;37;97;122m"
  Number                  = "$esc[38;2;150;77;16m"
  Operator                = "$esc[38;2;91;86;41m"
  Parameter               = "$esc[38;2;52;101;48m"
  String                  = "$esc[38;2;147;16;20m"
  Type                    = "$esc[38;2;49;99;85m"
  Variable                = "$esc[38;2;118;29;202m"
  ListPredictionSelected  = "$esc[48;2;179;174;237m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;179;174;237m" + "$esc[38;2;24;24;17m"
}