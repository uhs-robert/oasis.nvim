# extras/psreadline/themes/light/4/oasis_mirage_light_4.ps1
## name: Oasis Mirage Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;104;67;46m"
  Comment                 = "$esc[38;2;67;112;104m"
  ContinuationPrompt      = "$esc[38;2;94;107;106m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;67;1;146m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;127;134;134m"
  Keyword                 = "$esc[38;2;53;110;94m"
  ListPrediction          = "$esc[38;2;127;134;134m"
  ListPredictionTooltip   = "$esc[38;2;127;134;134m"
  Member                  = "$esc[38;2;38;100;126m"
  Number                  = "$esc[38;2;155;79;17m"
  Operator                = "$esc[38;2;46;97;81m"
  Parameter               = "$esc[38;2;54;105;50m"
  String                  = "$esc[38;2;152;17;22m"
  Type                    = "$esc[38;2;105;94;28m"
  Variable                = "$esc[38;2;121;31;210m"
  ListPredictionSelected  = "$esc[48;2;159;222;215m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;159;222;215m" + "$esc[38;2;24;24;17m"
}