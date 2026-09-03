# extras/psreadline/themes/light/1/oasis_canyon_light_1.ps1
## name: Oasis Canyon Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;82;75;28m"
  Comment                 = "$esc[38;2;130;96;80m"
  ContinuationPrompt      = "$esc[38;2;120;99;89m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;171;7;7m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;136;131;127m"
  Keyword                 = "$esc[38;2;174;61;29m"
  ListPrediction          = "$esc[38;2;136;131;127m"
  ListPredictionTooltip   = "$esc[38;2;136;131;127m"
  Member                  = "$esc[38;2;38;99;124m"
  Number                  = "$esc[38;2;154;79;17m"
  Operator                = "$esc[38;2;153;54;26m"
  Parameter               = "$esc[38;2;53;104;50m"
  String                  = "$esc[38;2;151;16;22m"
  Type                    = "$esc[38;2;50;102;87m"
  Variable                = "$esc[38;2;121;29;208m"
  ListPredictionSelected  = "$esc[48;2;231;195;165m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;231;195;165m" + "$esc[38;2;24;24;17m"
}