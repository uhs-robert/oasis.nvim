# extras/psreadline/themes/light/2/oasis_moonlight_light_2.ps1
## name: Oasis Moonlight Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;107;69;47m"
  Comment                 = "$esc[38;2;96;107;126m"
  ContinuationPrompt      = "$esc[38;2;99;108;116m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;163;5;5m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;132;136;141m"
  Keyword                 = "$esc[38;2;112;103;45m"
  ListPrediction          = "$esc[38;2;132;136;141m"
  ListPredictionTooltip   = "$esc[38;2;132;136;141m"
  Member                  = "$esc[38;2;39;103;128m"
  Number                  = "$esc[38;2;159;81;17m"
  Operator                = "$esc[38;2;97;91;44m"
  Parameter               = "$esc[38;2;56;107;51m"
  String                  = "$esc[38;2;157;17;23m"
  Type                    = "$esc[38;2;53;105;90m"
  Variable                = "$esc[38;2;125;30;215m"
  ListPredictionSelected  = "$esc[48;2;215;208;187m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;215;208;187m" + "$esc[38;2;24;24;17m"
}