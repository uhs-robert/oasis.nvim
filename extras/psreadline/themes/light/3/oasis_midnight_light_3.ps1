# extras/psreadline/themes/light/3/oasis_midnight_light_3.ps1
## name: Oasis Midnight Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;96;62;42m"
  Comment                 = "$esc[38;2;89;99;117m"
  ContinuationPrompt      = "$esc[38;2;90;100;107m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;49;115;43m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;121;127;132m"
  Keyword                 = "$esc[38;2;103;95;41m"
  ListPrediction          = "$esc[38;2;121;127;132m"
  ListPredictionTooltip   = "$esc[38;2;121;127;132m"
  Member                  = "$esc[38;2;36;94;119m"
  Number                  = "$esc[38;2;146;75;16m"
  Operator                = "$esc[38;2;88;83;40m"
  Parameter               = "$esc[38;2;51;98;47m"
  String                  = "$esc[38;2;142;15;20m"
  Type                    = "$esc[38;2;48;96;82m"
  Variable                = "$esc[38;2;113;28;197m"
  ListPredictionSelected  = "$esc[48;2;179;189;209m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;179;189;209m" + "$esc[38;2;24;24;17m"
}