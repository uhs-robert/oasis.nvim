# extras/psreadline/themes/dark/oasis_twilight_dark.ps1
## name: Oasis Twilight Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;240;230;140m"
  Comment                 = "$esc[38;2;139;128;170m"
  ContinuationPrompt      = "$esc[38;2;113;96;154m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;240;230;140m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;127;122;141m"
  Keyword                 = "$esc[38;2;249;175;150m"
  ListPrediction          = "$esc[38;2;127;122;141m"
  ListPredictionTooltip   = "$esc[38;2;127;122;141m"
  Member                  = "$esc[38;2;146;211;237m"
  Number                  = "$esc[38;2;255;163;77m"
  Operator                = "$esc[38;2;249;175;150m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;203;158;255m"
  ListPredictionSelected  = "$esc[48;2;54;35;67m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;54;35;67m" + "$esc[38;2;245;245;220m"
}