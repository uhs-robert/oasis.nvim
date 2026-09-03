# extras/psreadline/themes/light/3/oasis_dune_light_3.ps1
## name: Oasis Dune Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;107;69;46m"
  Comment                 = "$esc[38;2;118;104;95m"
  ContinuationPrompt      = "$esc[38;2;114;105;96m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;47;112;94m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;140;134;130m"
  Keyword                 = "$esc[38;2;115;102;28m"
  ListPrediction          = "$esc[38;2;140;134;130m"
  ListPredictionTooltip   = "$esc[38;2;140;134;130m"
  Member                  = "$esc[38;2;39;102;129m"
  Number                  = "$esc[38;2;158;81;17m"
  Operator                = "$esc[38;2;98;90;39m"
  Parameter               = "$esc[38;2;55;107;51m"
  String                  = "$esc[38;2;156;17;22m"
  Type                    = "$esc[38;2;52;105;90m"
  Variable                = "$esc[38;2;125;31;213m"
  ListPredictionSelected  = "$esc[48;2;237;207;160m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;237;207;160m" + "$esc[38;2;24;24;17m"
}