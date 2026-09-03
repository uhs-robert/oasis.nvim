# extras/psreadline/themes/dark/oasis_rose_dark.ps1
## name: Oasis Rose Dark
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;233;192;165m"
  Comment                 = "$esc[38;2;168;122;145m"
  ContinuationPrompt      = "$esc[38;2;129;97;117m"
  Default                 = "$esc[38;2;245;245;220m"
  Emphasis                = "$esc[38;2;124;205;181m"
  Error                   = "$esc[38;2;255;160;160m"
  InlinePrediction        = "$esc[38;2;140;125;134m"
  Keyword                 = "$esc[38;2;236;181;203m"
  ListPrediction          = "$esc[38;2;140;125;134m"
  ListPredictionTooltip   = "$esc[38;2;140;125;134m"
  Member                  = "$esc[38;2;135;206;235m"
  Number                  = "$esc[38;2;255;150;51m"
  Operator                = "$esc[38;2;223;147;177m"
  Parameter               = "$esc[38;2;127;207;120m"
  String                  = "$esc[38;2;255;160;160m"
  Type                    = "$esc[38;2;124;205;181m"
  Variable                = "$esc[38;2;203;158;255m"
  ListPredictionSelected  = "$esc[48;2;78;55;71m" + "$esc[38;2;245;245;220m"
  Selection               = "$esc[48;2;78;55;71m" + "$esc[38;2;245;245;220m"
}