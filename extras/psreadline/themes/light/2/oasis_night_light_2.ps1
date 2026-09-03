# extras/psreadline/themes/light/2/oasis_night_light_2.ps1
## name: Oasis Night Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;108;69;47m"
  Comment                 = "$esc[38;2;93;108;128m"
  ContinuationPrompt      = "$esc[38;2;98;109;118m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;163;5;5m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;132;136;142m"
  Keyword                 = "$esc[38;2;113;103;45m"
  ListPrediction          = "$esc[38;2;132;136;142m"
  ListPredictionTooltip   = "$esc[38;2;132;136;142m"
  Member                  = "$esc[38;2;40;103;128m"
  Number                  = "$esc[38;2;160;81;17m"
  Operator                = "$esc[38;2;97;91;44m"
  Parameter               = "$esc[38;2;56;108;51m"
  String                  = "$esc[38;2;157;17;23m"
  Type                    = "$esc[38;2;53;106;90m"
  Variable                = "$esc[38;2;126;31;216m"
  ListPredictionSelected  = "$esc[48;2;180;207;233m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;180;207;233m" + "$esc[38;2;24;24;17m"
}