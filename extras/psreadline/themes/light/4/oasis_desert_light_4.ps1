# extras/psreadline/themes/light/4/oasis_desert_light_4.ps1
## name: Oasis Desert Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;104;67;46m"
  Comment                 = "$esc[38;2;108;104;93m"
  ContinuationPrompt      = "$esc[38;2;106;104;96m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;45;108;39m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;134;133;127m"
  Keyword                 = "$esc[38;2;112;101;27m"
  ListPrediction          = "$esc[38;2;134;133;127m"
  ListPredictionTooltip   = "$esc[38;2;134;133;127m"
  Member                  = "$esc[38;2;38;100;126m"
  Number                  = "$esc[38;2;156;80;17m"
  Operator                = "$esc[38;2;96;88;38m"
  Parameter               = "$esc[38;2;54;105;50m"
  String                  = "$esc[38;2;153;17;22m"
  Type                    = "$esc[38;2;51;103;87m"
  Variable                = "$esc[38;2;122;31;208m"
  ListPredictionSelected  = "$esc[48;2;228;213;146m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;228;213;146m" + "$esc[38;2;24;24;17m"
}