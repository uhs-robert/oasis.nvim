# extras/psreadline/themes/light/2/oasis_abyss_light_2.ps1
## name: Oasis Abyss Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;98;63;43m"
  Comment                 = "$esc[38;2;103;100;90m"
  ContinuationPrompt      = "$esc[38;2;102;100;92m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;53;122;47m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;130;128;122m"
  Keyword                 = "$esc[38;2;105;96;42m"
  ListPrediction          = "$esc[38;2;130;128;122m"
  ListPredictionTooltip   = "$esc[38;2;130;128;122m"
  Member                  = "$esc[38;2;37;96;119m"
  Number                  = "$esc[38;2;149;76;16m"
  Operator                = "$esc[38;2;90;84;41m"
  Parameter               = "$esc[38;2;52;100;47m"
  String                  = "$esc[38;2;144;16;21m"
  Type                    = "$esc[38;2;49;98;84m"
  Variable                = "$esc[38;2;116;28;200m"
  ListPredictionSelected  = "$esc[48;2;193;193;193m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;193;193;193m" + "$esc[38;2;24;24;17m"
}