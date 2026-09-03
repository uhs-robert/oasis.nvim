# extras/psreadline/themes/light/2/oasis_rose_light_2.ps1
## name: Oasis Rose Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;104;67;45m"
  Comment                 = "$esc[38;2;126;96;111m"
  ContinuationPrompt      = "$esc[38;2;116;100;109m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;49;120;99m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;139;131;135m"
  Keyword                 = "$esc[38;2;170;60;104m"
  ListPrediction          = "$esc[38;2;139;131;135m"
  ListPredictionTooltip   = "$esc[38;2;139;131;135m"
  Member                  = "$esc[38;2;38;100;125m"
  Number                  = "$esc[38;2;156;79;17m"
  Operator                = "$esc[38;2;144;57;92m"
  Parameter               = "$esc[38;2;54;105;49m"
  String                  = "$esc[38;2;153;17;22m"
  Type                    = "$esc[38;2;51;103;88m"
  Variable                = "$esc[38;2;122;30;210m"
  ListPredictionSelected  = "$esc[48;2;232;179;213m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;232;179;213m" + "$esc[38;2;24;24;17m"
}