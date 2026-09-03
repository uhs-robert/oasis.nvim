# extras/psreadline/themes/dark/oasis_lagoon_dark.ps1
## name: Oasis Lagoon Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;77;136;167m"
  ContinuationPrompt      = "$esc[38;2;59;106;135m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;255;160;160m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;114;127;134m"
  Keyword                 = "$esc[38;2;113;184;255m"
  ListPrediction          = "$esc[38;2;114;127;134m"
  ListPredictionTooltip   = "$esc[38;2;114;127;134m"
  Member                  = "$esc[38;2;165;220;241m"
  Number                  = "$esc[38;2;255;163;77m"
  Operator                = "$esc[38;2;129;192;255m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;243;234;159m"
  Variable                = "$esc[38;2;194;142;255m"
  ListPredictionSelected  = "$esc[48;2;34;56;92m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;34;56;92m" + "$esc[38;2;245;245;220m"
}