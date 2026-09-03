# extras/psreadline/themes/light/4/oasis_dune_light_4.ps1
## name: Oasis Dune Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;102;65;44m"
  Comment                 = "$esc[38;2;113;100;91m"
  ContinuationPrompt      = "$esc[38;2;111;101;92m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;43;105;88m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;135;130;125m"
  Keyword                 = "$esc[38;2;110;99;27m"
  ListPrediction          = "$esc[38;2;135;130;125m"
  ListPredictionTooltip   = "$esc[38;2;135;130;125m"
  Member                  = "$esc[38;2;38;98;124m"
  Number                  = "$esc[38;2;153;78;17m"
  Operator                = "$esc[38;2;94;87;38m"
  Parameter               = "$esc[38;2;53;103;49m"
  String                  = "$esc[38;2;149;16;21m"
  Type                    = "$esc[38;2;50;101;85m"
  Variable                = "$esc[38;2;120;30;205m"
  ListPredictionSelected  = "$esc[48;2;236;199;147m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;236;199;147m" + "$esc[38;2;24;24;17m"
}