# extras/psreadline/themes/light/5/oasis_lagoon_light_5.ps1
## name: Oasis Lagoon Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;91;59;40m"
  Comment                 = "$esc[38;2;71;98;114m"
  ContinuationPrompt      = "$esc[38;2;79;97;107m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;138;0;0m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;116;123;126m"
  Keyword                 = "$esc[38;2;19;88;174m"
  ListPrediction          = "$esc[38;2;116;123;126m"
  ListPredictionTooltip   = "$esc[38;2;116;123;126m"
  Member                  = "$esc[38;2;33;90;112m"
  Number                  = "$esc[38;2;141;71;15m"
  Operator                = "$esc[38;2;16;77;151m"
  Parameter               = "$esc[38;2;49;94;44m"
  String                  = "$esc[38;2;134;15;19m"
  Type                    = "$esc[38;2;94;84;25m"
  Variable                = "$esc[38;2;109;26;188m"
  ListPredictionSelected  = "$esc[48;2;140;186;238m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;140;186;238m" + "$esc[38;2;24;24;17m"
}