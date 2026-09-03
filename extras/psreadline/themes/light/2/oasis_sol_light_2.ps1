# extras/psreadline/themes/light/2/oasis_sol_light_2.ps1
## name: Oasis Sol Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;93;60;40m"
  Comment                 = "$esc[38;2;112;91;88m"
  ContinuationPrompt      = "$esc[38;2;107;92;90m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;53;122;47m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;123;123;123m"
  Keyword                 = "$esc[38;2;174;38;42m"
  ListPrediction          = "$esc[38;2;123;123;123m"
  ListPredictionTooltip   = "$esc[38;2;123;123;123m"
  Member                  = "$esc[38;2;35;91;114m"
  Number                  = "$esc[38;2;143;73;16m"
  Operator                = "$esc[38;2;154;30;35m"
  Parameter               = "$esc[38;2;50;95;45m"
  String                  = "$esc[38;2;74;68;30m"
  Type                    = "$esc[38;2;47;94;80m"
  Variable                = "$esc[38;2;111;27;190m"
  ListPredictionSelected  = "$esc[48;2;234;159;159m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;234;159;159m" + "$esc[38;2;24;24;17m"
}