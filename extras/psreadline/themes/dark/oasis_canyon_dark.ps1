# extras/psreadline/themes/dark/oasis_canyon_dark.ps1
## name: Oasis Canyon Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;240;230;140m"
  Comment                 = "$esc[38;2;182;126;97m"
  ContinuationPrompt      = "$esc[38;2;154;101;73m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;255;144;144m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;137;124;117m"
  Keyword                 = "$esc[38;2;249;175;150m"
  ListPrediction          = "$esc[38;2;137;124;117m"
  ListPredictionTooltip   = "$esc[38;2;137;124;117m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;163;77m"
  Operator                = "$esc[38;2;249;175;150m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;203;158;255m"
  ListPredictionSelected  = "$esc[48;2;72;50;40m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;72;50;40m" + "$esc[38;2;245;245;220m"
}