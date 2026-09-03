# extras/psreadline/themes/light/2/oasis_lagoon_light_2.ps1
## name: Oasis Lagoon Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;112;72;49m"
  Comment                 = "$esc[38;2;82;114;134m"
  ContinuationPrompt      = "$esc[38;2;92;113;126m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;163;5;5m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;134;140;144m"
  Keyword                 = "$esc[38;2;22;104;204m"
  ListPrediction          = "$esc[38;2;134;140;144m"
  ListPredictionTooltip   = "$esc[38;2;134;140;144m"
  Member                  = "$esc[38;2;39;106;132m"
  Number                  = "$esc[38;2;165;84;18m"
  Operator                = "$esc[38;2;20;92;180m"
  Parameter               = "$esc[38;2;58;111;52m"
  String                  = "$esc[38;2;163;18;24m"
  Type                    = "$esc[38;2;111;100;29m"
  Variable                = "$esc[38;2;129;32;222m"
  ListPredictionSelected  = "$esc[48;2;179;210;245m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;179;210;245m" + "$esc[38;2;24;24;17m"
}