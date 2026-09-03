# extras/psreadline/themes/light/3/oasis_moonlight_light_3.ps1
## name: Oasis Moonlight Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;102;66;44m"
  Comment                 = "$esc[38;2;93;103;122m"
  ContinuationPrompt      = "$esc[38;2;94;104;112m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;155;3;3m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;127;132;137m"
  Keyword                 = "$esc[38;2;107;99;43m"
  ListPrediction          = "$esc[38;2;127;132;137m"
  ListPredictionTooltip   = "$esc[38;2;127;132;137m"
  Member                  = "$esc[38;2;37;98;124m"
  Number                  = "$esc[38;2;153;79;17m"
  Operator                = "$esc[38;2;92;87;42m"
  Parameter               = "$esc[38;2;53;103;49m"
  String                  = "$esc[38;2;149;16;21m"
  Type                    = "$esc[38;2;50;101;86m"
  Variable                = "$esc[38;2;119;30;207m"
  ListPredictionSelected  = "$esc[48;2;209;203;178m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;209;203;178m" + "$esc[38;2;24;24;17m"
}