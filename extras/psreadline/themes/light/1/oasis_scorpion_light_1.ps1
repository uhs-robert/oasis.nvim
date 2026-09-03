# extras/psreadline/themes/light/1/oasis_scorpion_light_1.ps1
## name: Oasis Scorpion Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;105;67;45m"
  Comment                 = "$esc[38;2;126;98;94m"
  ContinuationPrompt      = "$esc[38;2;117;102;99m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;133;124;45m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;139;132;130m"
  Keyword                 = "$esc[38;2;111;101;44m"
  ListPrediction          = "$esc[38;2;139;132;130m"
  ListPredictionTooltip   = "$esc[38;2;139;132;130m"
  Member                  = "$esc[38;2;38;101;126m"
  Number                  = "$esc[38;2;156;80;17m"
  Operator                = "$esc[38;2;95;89;43m"
  Parameter               = "$esc[38;2;54;105;50m"
  String                  = "$esc[38;2;153;17;22m"
  Type                    = "$esc[38;2;51;103;88m"
  Variable                = "$esc[38;2;123;30;211m"
  ListPredictionSelected  = "$esc[48;2;240;187;169m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;240;187;169m" + "$esc[38;2;24;24;17m"
}