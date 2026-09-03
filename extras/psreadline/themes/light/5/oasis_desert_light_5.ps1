# extras/psreadline/themes/light/5/oasis_desert_light_5.ps1
## name: Oasis Desert Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;100;65;44m"
  Comment                 = "$esc[38;2;105;102;90m"
  ContinuationPrompt      = "$esc[38;2;105;102;93m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;41;102;36m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;131;130;124m"
  Keyword                 = "$esc[38;2;108;98;26m"
  ListPrediction          = "$esc[38;2;131;130;124m"
  ListPredictionTooltip   = "$esc[38;2;131;130;124m"
  Member                  = "$esc[38;2;36;98;122m"
  Number                  = "$esc[38;2;152;77;17m"
  Operator                = "$esc[38;2;93;86;37m"
  Parameter               = "$esc[38;2;53;102;48m"
  String                  = "$esc[38;2;148;16;21m"
  Type                    = "$esc[38;2;50;100;85m"
  Variable                = "$esc[38;2;118;29;204m"
  ListPredictionSelected  = "$esc[48;2;225;210;134m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;225;210;134m" + "$esc[38;2;24;24;17m"
}