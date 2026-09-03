# extras/psreadline/themes/dark/oasis_abyss_dark.ps1
## name: Oasis Abyss Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;122;118;98m"
  ContinuationPrompt      = "$esc[38;2;96;92;77m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;127;207;120m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;123;120;109m"
  Keyword                 = "$esc[38;2;216;207;127m"
  ListPrediction          = "$esc[38;2;123;120;109m"
  ListPredictionTooltip   = "$esc[38;2;123;120;109m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;150;51m"
  Operator                = "$esc[38;2;205;198;115m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;194;142;255m"
  ListPredictionSelected  = "$esc[48;2;83;46;46m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;83;46;46m" + "$esc[38;2;245;245;220m"
}