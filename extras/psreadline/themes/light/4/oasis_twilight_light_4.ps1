# extras/psreadline/themes/light/4/oasis_twilight_light_4.ps1
## name: Oasis Twilight Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;74;68;25m"
  Comment                 = "$esc[38;2;99;92;118m"
  ContinuationPrompt      = "$esc[38;2;98;93;110m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;130;119;18m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;124;122;131m"
  Keyword                 = "$esc[38;2;160;57;28m"
  ListPrediction          = "$esc[38;2;124;122;131m"
  ListPredictionTooltip   = "$esc[38;2;124;122;131m"
  Member                  = "$esc[38;2;35;91;114m"
  Number                  = "$esc[38;2;142;73;15m"
  Operator                = "$esc[38;2;140;50;24m"
  Parameter               = "$esc[38;2;49;96;46m"
  String                  = "$esc[38;2;136;15;19m"
  Type                    = "$esc[38;2;46;94;79m"
  Variable                = "$esc[38;2;111;28;189m"
  ListPredictionSelected  = "$esc[48;2;197;167;224m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;197;167;224m" + "$esc[38;2;24;24;17m"
}