# extras/psreadline/themes/light/3/oasis_canyon_light_3.ps1
## name: Oasis Canyon Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;73;67;25m"
  Comment                 = "$esc[38;2;119;88;74m"
  ContinuationPrompt      = "$esc[38;2;109;91;82m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;155;3;3m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;128;121;117m"
  Keyword                 = "$esc[38;2;159;56;26m"
  ListPrediction          = "$esc[38;2;128;121;117m"
  ListPredictionTooltip   = "$esc[38;2;128;121;117m"
  Member                  = "$esc[38;2;34;90;114m"
  Number                  = "$esc[38;2;140;72;15m"
  Operator                = "$esc[38;2;138;49;23m"
  Parameter               = "$esc[38;2;48;94;45m"
  String                  = "$esc[38;2;134;15;19m"
  Type                    = "$esc[38;2;46;92;79m"
  Variable                = "$esc[38;2;109;27;187m"
  ListPredictionSelected  = "$esc[48;2;225;179;140m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;225;179;140m" + "$esc[38;2;24;24;17m"
}