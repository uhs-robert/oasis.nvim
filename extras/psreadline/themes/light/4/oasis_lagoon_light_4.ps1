# extras/psreadline/themes/light/4/oasis_lagoon_light_4.ps1
## name: Oasis Lagoon Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;98;63;43m"
  Comment                 = "$esc[38;2;75;103;122m"
  ContinuationPrompt      = "$esc[38;2;84;102;114m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;146;1;1m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;123;129;133m"
  Keyword                 = "$esc[38;2;20;94;183m"
  ListPrediction          = "$esc[38;2;123;129;133m"
  ListPredictionTooltip   = "$esc[38;2;123;129;133m"
  Member                  = "$esc[38;2;35;96;119m"
  Number                  = "$esc[38;2;149;76;16m"
  Operator                = "$esc[38;2;17;82;161m"
  Parameter               = "$esc[38;2;51;100;48m"
  String                  = "$esc[38;2;144;16;20m"
  Type                    = "$esc[38;2;100;89;27m"
  Variable                = "$esc[38;2;115;29;200m"
  ListPredictionSelected  = "$esc[48;2;154;194;240m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;154;194;240m" + "$esc[38;2;24;24;17m"
}