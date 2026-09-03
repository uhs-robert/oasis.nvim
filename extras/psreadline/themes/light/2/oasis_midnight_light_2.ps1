# extras/psreadline/themes/light/2/oasis_midnight_light_2.ps1
## name: Oasis Midnight Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;103;66;45m"
  Comment                 = "$esc[38;2;93;104;122m"
  ContinuationPrompt      = "$esc[38;2;96;105;112m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;53;122;47m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;127;133;137m"
  Keyword                 = "$esc[38;2;109;100;44m"
  ListPrediction          = "$esc[38;2;127;133;137m"
  ListPredictionTooltip   = "$esc[38;2;127;133;137m"
  Member                  = "$esc[38;2;38;99;124m"
  Number                  = "$esc[38;2;155;79;17m"
  Operator                = "$esc[38;2;94;88;42m"
  Parameter               = "$esc[38;2;54;104;49m"
  String                  = "$esc[38;2;151;16;22m"
  Type                    = "$esc[38;2;51;102;87m"
  Variable                = "$esc[38;2;121;29;208m"
  ListPredictionSelected  = "$esc[48;2;189;196;215m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;189;196;215m" + "$esc[38;2;24;24;17m"
}