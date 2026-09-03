# extras/psreadline/themes/light/5/oasis_sol_light_5.ps1
## name: Oasis Sol Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;65;42;28m"
  Comment                 = "$esc[38;2;89;72;70m"
  ContinuationPrompt      = "$esc[38;2;85;73;71m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;41;102;36m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;102;102;102m"
  Keyword                 = "$esc[38;2;137;31;33m"
  ListPrediction          = "$esc[38;2;102;102;102m"
  ListPredictionTooltip   = "$esc[38;2;102;102;102m"
  Member                  = "$esc[38;2;26;70;88m"
  Number                  = "$esc[38;2;113;57;12m"
  Operator                = "$esc[38;2;117;23;26m"
  Parameter               = "$esc[38;2;38;73;34m"
  String                  = "$esc[38;2;51;47;21m"
  Type                    = "$esc[38;2;36;72;61m"
  Variable                = "$esc[38;2;84;20;145m"
  ListPredictionSelected  = "$esc[48;2;225;121;121m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;225;121;121m" + "$esc[38;2;24;24;17m"
}