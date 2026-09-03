# extras/psreadline/themes/light/1/oasis_luna_light_1.ps1
## name: Oasis Luna Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;114;73;49m"
  Comment                 = "$esc[38;2;117;105;154m"
  ContinuationPrompt      = "$esc[38;2;113;109;129m"
  Default                 = "$esc[38;2;25;25;17m"
  Emphasis                = "$esc[38;2;27;123;152m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;141;140;149m"
  Keyword                 = "$esc[38;2;118;108;47m"
  ListPrediction          = "$esc[38;2;141;140;149m"
  ListPredictionTooltip   = "$esc[38;2;141;140;149m"
  Member                  = "$esc[38;2;41;108;135m"
  Number                  = "$esc[38;2;167;85;18m"
  Operator                = "$esc[38;2;102;96;46m"
  Parameter               = "$esc[38;2;58;113;54m"
  String                  = "$esc[38;2;166;18;24m"
  Type                    = "$esc[38;2;55;111;95m"
  Variable                = "$esc[38;2;131;34;224m"
  ListPredictionSelected  = "$esc[48;2;194;194;240m" + "$esc[38;2;25;25;17m"
  Selection               = "$esc[48;2;194;194;240m" + "$esc[38;2;25;25;17m"
}