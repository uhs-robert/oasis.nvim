# extras/psreadline/themes/dark/oasis_starlight_dark.ps1
## name: Oasis Starlight Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;94;124;154m"
  ContinuationPrompt      = "$esc[38;2;79;91;107m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;255;160;160m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;110;125;129m"
  Keyword                 = "$esc[38;2;216;207;127m"
  ListPrediction          = "$esc[38;2;110;125;129m"
  ListPredictionTooltip   = "$esc[38;2;110;125;129m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;150;51m"
  Operator                = "$esc[38;2;205;198;115m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;144;144m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;168;112;240m"
  ListPredictionSelected  = "$esc[48;2;77;69;40m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;77;69;40m" + "$esc[38;2;245;245;220m"
}