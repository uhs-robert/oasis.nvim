# extras/psreadline/themes/light/2/oasis_luna_light_2.ps1
## name: Oasis Luna Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;109;70;48m"
  Comment                 = "$esc[38;2;113;101;151m"
  ContinuationPrompt      = "$esc[38;2;109;106;127m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;24;117;144m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;138;136;145m"
  Keyword                 = "$esc[38;2;114;105;46m"
  ListPrediction          = "$esc[38;2;138;136;145m"
  ListPredictionTooltip   = "$esc[38;2;138;136;145m"
  Member                  = "$esc[38;2;40;104;130m"
  Number                  = "$esc[38;2;162;82;18m"
  Operator                = "$esc[38;2;98;93;45m"
  Parameter               = "$esc[38;2;56;109;51m"
  String                  = "$esc[38;2;159;17;23m"
  Type                    = "$esc[38;2;53;107;91m"
  Variable                = "$esc[38;2;127;31;218m"
  ListPredictionSelected  = "$esc[48;2;193;185;240m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;193;185;240m" + "$esc[38;2;24;24;17m"
}