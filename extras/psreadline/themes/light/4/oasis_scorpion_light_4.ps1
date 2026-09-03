# extras/psreadline/themes/light/4/oasis_scorpion_light_4.ps1
## name: Oasis Scorpion Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;84;54;36m"
  Comment                 = "$esc[38;2;107;84;79m"
  ContinuationPrompt      = "$esc[38;2;99;86;83m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;113;105;35m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;121;115;113m"
  Keyword                 = "$esc[38;2;93;85;37m"
  ListPrediction          = "$esc[38;2;121;115;113m"
  ListPredictionTooltip   = "$esc[38;2;121;115;113m"
  Member                  = "$esc[38;2;32;84;106m"
  Number                  = "$esc[38;2;132;67;14m"
  Operator                = "$esc[38;2;78;73;36m"
  Parameter               = "$esc[38;2;45;88;42m"
  String                  = "$esc[38;2;124;13;17m"
  Type                    = "$esc[38;2;43;86;73m"
  Variable                = "$esc[38;2;101;26;175m"
  ListPredictionSelected  = "$esc[48;2;233;156;130m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;233;156;130m" + "$esc[38;2;24;24;17m"
}