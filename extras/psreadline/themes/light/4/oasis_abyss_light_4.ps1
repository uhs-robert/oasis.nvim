# extras/psreadline/themes/light/4/oasis_abyss_light_4.ps1
## name: Oasis Abyss Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;85;54;37m"
  Comment                 = "$esc[38;2;93;90;80m"
  ContinuationPrompt      = "$esc[38;2;91;90;82m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;45;108;39m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;118;117;112m"
  Keyword                 = "$esc[38;2;94;86;37m"
  ListPrediction          = "$esc[38;2;118;117;112m"
  ListPredictionTooltip   = "$esc[38;2;118;117;112m"
  Member                  = "$esc[38;2;32;85;107m"
  Number                  = "$esc[38;2;133;68;14m"
  Operator                = "$esc[38;2;79;74;36m"
  Parameter               = "$esc[38;2;45;89;42m"
  String                  = "$esc[38;2;125;14;18m"
  Type                    = "$esc[38;2;43;87;73m"
  Variable                = "$esc[38;2;102;26;177m"
  ListPredictionSelected  = "$esc[48;2;177;177;177m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;177;177;177m" + "$esc[38;2;24;24;17m"
}