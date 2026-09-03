# extras/psreadline/themes/light/1/oasis_abyss_light_1.ps1
## name: Oasis Abyss Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;104;67;45m"
  Comment                 = "$esc[38;2;107;104;93m"
  ContinuationPrompt      = "$esc[38;2;106;104;95m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;56;128;50m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;134;133;127m"
  Keyword                 = "$esc[38;2;110;100;44m"
  ListPrediction          = "$esc[38;2;134;133;127m"
  ListPredictionTooltip   = "$esc[38;2;134;133;127m"
  Member                  = "$esc[38;2;38;100;125m"
  Number                  = "$esc[38;2;155;80;17m"
  Operator                = "$esc[38;2;94;89;42m"
  Parameter               = "$esc[38;2;54;104;50m"
  String                  = "$esc[38;2;152;17;22m"
  Type                    = "$esc[38;2;51;103;88m"
  Variable                = "$esc[38;2;122;29;210m"
  ListPredictionSelected  = "$esc[48;2;200;200;200m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;200;200;200m" + "$esc[38;2;24;24;17m"
}