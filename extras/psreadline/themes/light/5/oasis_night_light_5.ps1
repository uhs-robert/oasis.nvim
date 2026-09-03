# extras/psreadline/themes/light/5/oasis_night_light_5.ps1
## name: Oasis Night Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;85;55;37m"
  Comment                 = "$esc[38;2;79;92;108m"
  ContinuationPrompt      = "$esc[38;2;83;91;100m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;138;0;0m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;113;118;122m"
  Keyword                 = "$esc[38;2;94;87;38m"
  ListPrediction          = "$esc[38;2;113;118;122m"
  ListPredictionTooltip   = "$esc[38;2;113;118;122m"
  Member                  = "$esc[38;2;32;86;107m"
  Number                  = "$esc[38;2;135;68;15m"
  Operator                = "$esc[38;2;80;75;37m"
  Parameter               = "$esc[38;2;46;89;42m"
  String                  = "$esc[38;2;127;14;18m"
  Type                    = "$esc[38;2;44;88;75m"
  Variable                = "$esc[38;2;104;25;179m"
  ListPredictionSelected  = "$esc[48;2;132;183;230m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;132;183;230m" + "$esc[38;2;24;24;17m"
}