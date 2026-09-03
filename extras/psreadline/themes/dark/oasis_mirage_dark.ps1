# extras/psreadline/themes/dark/oasis_mirage_dark.ps1
## name: Oasis Mirage Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;67;151;137m"
  ContinuationPrompt      = "$esc[38;2;88;114;112m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;210;173;255m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;115;130;129m"
  Keyword                 = "$esc[38;2;138;211;190m"
  ListPrediction          = "$esc[38;2;115;130;129m"
  ListPredictionTooltip   = "$esc[38;2;115;130;129m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;163;77m"
  Operator                = "$esc[38;2;124;205;181m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;243;234;159m"
  Variable                = "$esc[38;2;194;142;255m"
  ListPredictionSelected  = "$esc[48;2;33;51;59m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;33;51;59m" + "$esc[38;2;245;245;220m"
}