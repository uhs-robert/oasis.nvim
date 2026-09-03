# extras/psreadline/themes/light/3/oasis_scorpion_light_3.ps1
## name: Oasis Scorpion Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;90;58;39m"
  Comment                 = "$esc[38;2;113;89;84m"
  ContinuationPrompt      = "$esc[38;2;105;91;88m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;119;111;39m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;128;120;117m"
  Keyword                 = "$esc[38;2;98;91;39m"
  ListPrediction          = "$esc[38;2;128;120;117m"
  ListPredictionTooltip   = "$esc[38;2;128;120;117m"
  Member                  = "$esc[38;2;34;89;113m"
  Number                  = "$esc[38;2;140;72;15m"
  Operator                = "$esc[38;2;83;79;38m"
  Parameter               = "$esc[38;2;48;93;44m"
  String                  = "$esc[38;2;134;15;19m"
  Type                    = "$esc[38;2;45;92;78m"
  Variable                = "$esc[38;2;108;27;187m"
  ListPredictionSelected  = "$esc[48;2;235;166;143m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;235;166;143m" + "$esc[38;2;24;24;17m"
}