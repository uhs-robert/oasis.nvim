# extras/psreadline/themes/light/1/oasis_midnight_light_1.ps1
## name: Oasis Midnight Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;110;71;47m"
  Comment                 = "$esc[38;2;98;110;129m"
  ContinuationPrompt      = "$esc[38;2;100;110;119m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;56;128;50m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;133;139;143m"
  Keyword                 = "$esc[38;2;115;105;46m"
  ListPrediction          = "$esc[38;2;133;139;143m"
  ListPredictionTooltip   = "$esc[38;2;133;139;143m"
  Member                  = "$esc[38;2;40;105;131m"
  Number                  = "$esc[38;2;162;83;18m"
  Operator                = "$esc[38;2;99;93;45m"
  Parameter               = "$esc[38;2;56;110;52m"
  String                  = "$esc[38;2;160;18;23m"
  Type                    = "$esc[38;2;53;108;92m"
  Variable                = "$esc[38;2;128;31;220m"
  ListPredictionSelected  = "$esc[48;2;197;206;222m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;197;206;222m" + "$esc[38;2;24;24;17m"
}