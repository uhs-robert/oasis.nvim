# extras/psreadline/themes/light/5/oasis_mirage_light_5.ps1
## name: Oasis Mirage Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;99;64;43m"
  Comment                 = "$esc[38;2;65;109;102m"
  ContinuationPrompt      = "$esc[38;2;91;103;102m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;62;0;138m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;123;131;131m"
  Keyword                 = "$esc[38;2;49;107;90m"
  ListPrediction          = "$esc[38;2;123;131;131m"
  ListPredictionTooltip   = "$esc[38;2;123;131;131m"
  Member                  = "$esc[38;2;36;97;121m"
  Number                  = "$esc[38;2;151;76;16m"
  Operator                = "$esc[38;2;44;93;80m"
  Parameter               = "$esc[38;2;52;101;48m"
  String                  = "$esc[38;2;146;16;21m"
  Type                    = "$esc[38;2;101;91;27m"
  Variable                = "$esc[38;2;117;28;203m"
  ListPredictionSelected  = "$esc[48;2;147;219;212m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;147;219;212m" + "$esc[38;2;24;24;17m"
}