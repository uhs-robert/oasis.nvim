# extras/psreadline/themes/dark/oasis_cactus_dark.ps1
## name: Oasis Cactus Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;105;149;109m"
  ContinuationPrompt      = "$esc[38;2;91;115;96m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;255;160;160m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;116;132;119m"
  Keyword                 = "$esc[38;2;174;214;176m"
  ListPrediction          = "$esc[38;2;116;132;119m"
  ListPredictionTooltip   = "$esc[38;2;116;132;119m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;163;77m"
  Operator                = "$esc[38;2;167;211;169m"
  Parameter               = "$esc[38;2;255;208;92m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;194;142;255m"
  ListPredictionSelected  = "$esc[48;2;47;61;51m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;47;61;51m" + "$esc[38;2;245;245;220m"
}