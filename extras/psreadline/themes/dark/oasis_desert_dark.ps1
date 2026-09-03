# extras/psreadline/themes/dark/oasis_desert_dark.ps1
## name: Oasis Desert Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;148;143;122m"
  ContinuationPrompt      = "$esc[38;2;119;114;95m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;127;207;120m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;135;132;120m"
  Keyword                 = "$esc[38;2;240;230;140m"
  ListPrediction          = "$esc[38;2;135;132;120m"
  ListPredictionTooltip   = "$esc[38;2;135;132;120m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;163;77m"
  Operator                = "$esc[38;2;216;207;127m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;203;158;255m"
  ListPredictionSelected  = "$esc[48;2;67;63;56m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;67;63;56m" + "$esc[38;2;245;245;220m"
}