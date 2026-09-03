# extras/psreadline/themes/light/3/oasis_lagoon_light_3.ps1
## name: Oasis Lagoon Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;105;68;46m"
  Comment                 = "$esc[38;2;80;109;129m"
  ContinuationPrompt      = "$esc[38;2;88;108;120m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;155;3;3m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;128;135;138m"
  Keyword                 = "$esc[38;2;21;99;193m"
  ListPrediction          = "$esc[38;2;128;135;138m"
  ListPredictionTooltip   = "$esc[38;2;128;135;138m"
  Member                  = "$esc[38;2;36;101;126m"
  Number                  = "$esc[38;2;156;80;17m"
  Operator                = "$esc[38;2;18;87;169m"
  Parameter               = "$esc[38;2;54;106;50m"
  String                  = "$esc[38;2;154;17;21m"
  Type                    = "$esc[38;2;106;94;28m"
  Variable                = "$esc[38;2;122;31;212m"
  ListPredictionSelected  = "$esc[48;2;166;202;242m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;166;202;242m" + "$esc[38;2;24;24;17m"
}