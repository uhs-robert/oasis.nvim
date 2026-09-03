# extras/psreadline/themes/light/4/oasis_sol_light_4.ps1
## name: Oasis Sol Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;74;48;32m"
  Comment                 = "$esc[38;2;96;78;75m"
  ContinuationPrompt      = "$esc[38;2;93;79;77m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;45;108;39m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;109;109;109m"
  Keyword                 = "$esc[38;2;150;32;36m"
  ListPrediction          = "$esc[38;2;109;109;109m"
  ListPredictionTooltip   = "$esc[38;2;109;109;109m"
  Member                  = "$esc[38;2;29;77;97m"
  Number                  = "$esc[38;2;122;62;13m"
  Operator                = "$esc[38;2;129;26;29m"
  Parameter               = "$esc[38;2;41;81;39m"
  String                  = "$esc[38;2;59;54;23m"
  Type                    = "$esc[38;2;39;79;67m"
  Variable                = "$esc[38;2;93;23;159m"
  ListPredictionSelected  = "$esc[48;2;228;133;133m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;228;133;133m" + "$esc[38;2;24;24;17m"
}