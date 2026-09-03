# extras/psreadline/themes/light/4/oasis_rose_light_4.ps1
## name: Oasis Rose Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;89;57;39m"
  Comment                 = "$esc[38;2;113;85;99m"
  ContinuationPrompt      = "$esc[38;2;103;89;97m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;42;106;87m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;124;118;122m"
  Keyword                 = "$esc[38;2;150;54;92m"
  ListPrediction          = "$esc[38;2;124;118;122m"
  ListPredictionTooltip   = "$esc[38;2;124;118;122m"
  Member                  = "$esc[38;2;34;88;111m"
  Number                  = "$esc[38;2;138;70;15m"
  Operator                = "$esc[38;2;126;50;79m"
  Parameter               = "$esc[38;2;47;92;44m"
  String                  = "$esc[38;2;131;14;18m"
  Type                    = "$esc[38;2;45;90;76m"
  Variable                = "$esc[38;2;107;27;182m"
  ListPredictionSelected  = "$esc[48;2;227;154;198m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;227;154;198m" + "$esc[38;2;24;24;17m"
}