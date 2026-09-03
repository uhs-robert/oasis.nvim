# extras/psreadline/themes/light/5/oasis_scorpion_light_5.ps1
## name: Oasis Scorpion Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;75;49;33m"
  Comment                 = "$esc[38;2;100;78;73m"
  ContinuationPrompt      = "$esc[38;2;92;80;79m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;106;98;32m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;114;108;105m"
  Keyword                 = "$esc[38;2;86;79;34m"
  ListPrediction          = "$esc[38;2;114;108;105m"
  ListPredictionTooltip   = "$esc[38;2;114;108;105m"
  Member                  = "$esc[38;2;29;78;98m"
  Number                  = "$esc[38;2;123;62;13m"
  Operator                = "$esc[38;2;72;67;33m"
  Parameter               = "$esc[38;2;42;81;38m"
  String                  = "$esc[38;2;112;12;16m"
  Type                    = "$esc[38;2;40;80;68m"
  Variable                = "$esc[38;2;94;23;162m"
  ListPredictionSelected  = "$esc[48;2;229;145;117m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;229;145;117m" + "$esc[38;2;24;24;17m"
}