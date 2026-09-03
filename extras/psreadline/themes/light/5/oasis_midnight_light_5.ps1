# extras/psreadline/themes/light/5/oasis_midnight_light_5.ps1
## name: Oasis Midnight Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;81;53;35m"
  Comment                 = "$esc[38;2;78;88;102m"
  ContinuationPrompt      = "$esc[38;2;81;89;95m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;41;102;36m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;110;115;119m"
  Keyword                 = "$esc[38;2;91;84;36m"
  ListPrediction          = "$esc[38;2;110;115;119m"
  ListPredictionTooltip   = "$esc[38;2;110;115;119m"
  Member                  = "$esc[38;2;31;83;104m"
  Number                  = "$esc[38;2;131;66;14m"
  Operator                = "$esc[38;2;77;72;35m"
  Parameter               = "$esc[38;2;45;86;41m"
  String                  = "$esc[38;2;121;13;17m"
  Type                    = "$esc[38;2;42;85;72m"
  Variable                = "$esc[38;2;100;24;172m"
  ListPredictionSelected  = "$esc[48;2;160;172;197m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;160;172;197m" + "$esc[38;2;24;24;17m"
}