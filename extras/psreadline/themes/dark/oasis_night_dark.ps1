# extras/psreadline/themes/dark/oasis_night_dark.ps1
## name: Oasis Night Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;112;140;168m"
  ContinuationPrompt      = "$esc[38;2;83;107;131m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;255;160;160m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;114;123;133m"
  Keyword                 = "$esc[38;2;216;207;127m"
  ListPrediction          = "$esc[38;2;114;123;133m"
  ListPredictionTooltip   = "$esc[38;2;114;123;133m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;150;51m"
  Operator                = "$esc[38;2;205;198;115m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;194;142;255m"
  ListPredictionSelected  = "$esc[48;2;36;54;77m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;36;54;77m" + "$esc[38;2;245;245;220m"
}