# extras/psreadline/themes/light/3/oasis_cactus_light_3.ps1
## name: Oasis Cactus Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;106;69;46m"
  Comment                 = "$esc[38;2;89;112;92m"
  ContinuationPrompt      = "$esc[38;2;97;109;100m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;155;3;3m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;129;137;130m"
  Keyword                 = "$esc[38;2;65;113;68m"
  ListPrediction          = "$esc[38;2;129;137;130m"
  ListPredictionTooltip   = "$esc[38;2;129;137;130m"
  Member                  = "$esc[38;2;39;102;129m"
  Number                  = "$esc[38;2;158;81;17m"
  Operator                = "$esc[38;2;57;99;60m"
  Parameter               = "$esc[38;2;124;89;18m"
  String                  = "$esc[38;2;156;17;22m"
  Type                    = "$esc[38;2;52;105;89m"
  Variable                = "$esc[38;2;123;31;214m"
  ListPredictionSelected  = "$esc[48;2;178;220;193m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;178;220;193m" + "$esc[38;2;24;24;17m"
}