# extras/psreadline/themes/light/3/oasis_abyss_light_3.ps1
## name: Oasis Abyss Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;91;59;40m"
  Comment                 = "$esc[38;2;98;95;84m"
  ContinuationPrompt      = "$esc[38;2;97;95;87m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;49;115;43m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;124;122;116m"
  Keyword                 = "$esc[38;2;99;92;40m"
  ListPrediction          = "$esc[38;2;124;122;116m"
  ListPredictionTooltip   = "$esc[38;2;124;122;116m"
  Member                  = "$esc[38;2;34;90;114m"
  Number                  = "$esc[38;2;141;72;15m"
  Operator                = "$esc[38;2;84;79;38m"
  Parameter               = "$esc[38;2;49;94;45m"
  String                  = "$esc[38;2;135;15;19m"
  Type                    = "$esc[38;2;46;93;79m"
  Variable                = "$esc[38;2;109;27;189m"
  ListPredictionSelected  = "$esc[48;2;185;185;185m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;185;185;185m" + "$esc[38;2;24;24;17m"
}