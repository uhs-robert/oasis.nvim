# extras/psreadline/themes/light/5/oasis_twilight_light_5.ps1
## name: Oasis Twilight Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;67;61;22m"
  Comment                 = "$esc[38;2;94;85;111m"
  ContinuationPrompt      = "$esc[38;2;91;87;102m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;122;111;16m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;118;115;124m"
  Keyword                 = "$esc[38;2;149;53;25m"
  ListPrediction          = "$esc[38;2;118;115;124m"
  ListPredictionTooltip   = "$esc[38;2;118;115;124m"
  Member                  = "$esc[38;2;31;84;106m"
  Number                  = "$esc[38;2;133;67;14m"
  Operator                = "$esc[38;2;129;46;21m"
  Parameter               = "$esc[38;2;46;88;41m"
  String                  = "$esc[38;2;124;13;18m"
  Type                    = "$esc[38;2;43;86;74m"
  Variable                = "$esc[38;2;102;25;176m"
  ListPredictionSelected  = "$esc[48;2;189;155;220m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;189;155;220m" + "$esc[38;2;24;24;17m"
}