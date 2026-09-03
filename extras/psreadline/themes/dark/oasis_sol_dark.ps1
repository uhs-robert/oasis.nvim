# extras/psreadline/themes/dark/oasis_sol_dark.ps1
## name: Oasis Sol Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;162;125;120m"
  ContinuationPrompt      = "$esc[38;2;131;97;91m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;127;207;120m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;126;126;126m"
  Keyword                 = "$esc[38;2;243;148;147m"
  ListPrediction          = "$esc[38;2;126;126;126m"
  ListPredictionTooltip   = "$esc[38;2;126;126;126m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;150;51m"
  Operator                = "$esc[38;2;245;139;139m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;216;207;127m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;203;158;255m"
  ListPredictionSelected  = "$esc[48;2;67;40;35m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;67;40;35m" + "$esc[38;2;245;245;220m"
}