# extras/psreadline/themes/light/4/oasis_moonlight_light_4.ps1
## name: Oasis Moonlight Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;97;62;42m"
  Comment                 = "$esc[38;2;88;100;118m"
  ContinuationPrompt      = "$esc[38;2;91;100;108m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;146;1;1m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;123;127;132m"
  Keyword                 = "$esc[38;2;104;95;41m"
  ListPrediction          = "$esc[38;2;123;127;132m"
  ListPredictionTooltip   = "$esc[38;2;123;127;132m"
  Member                  = "$esc[38;2;36;95;119m"
  Number                  = "$esc[38;2;147;75;16m"
  Operator                = "$esc[38;2;88;83;40m"
  Parameter               = "$esc[38;2;50;99;47m"
  String                  = "$esc[38;2;142;15;20m"
  Type                    = "$esc[38;2;48;97;82m"
  Variable                = "$esc[38;2;114;29;198m"
  ListPredictionSelected  = "$esc[48;2;203;198;168m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;203;198;168m" + "$esc[38;2;24;24;17m"
}