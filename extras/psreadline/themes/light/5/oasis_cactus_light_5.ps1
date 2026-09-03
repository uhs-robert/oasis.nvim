# extras/psreadline/themes/light/5/oasis_cactus_light_5.ps1
## name: Oasis Cactus Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;96;62;42m"
  Comment                 = "$esc[38;2;82;104;84m"
  ContinuationPrompt      = "$esc[38;2;90;101;93m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;138;0;0m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;120;128;123m"
  Keyword                 = "$esc[38;2;61;104;63m"
  ListPrediction          = "$esc[38;2;120;128;123m"
  ListPredictionTooltip   = "$esc[38;2;120;128;123m"
  Member                  = "$esc[38;2;35;94;118m"
  Number                  = "$esc[38;2;147;74;16m"
  Operator                = "$esc[38;2;53;90;55m"
  Parameter               = "$esc[38;2;113;82;16m"
  String                  = "$esc[38;2;142;15;20m"
  Type                    = "$esc[38;2;48;96;82m"
  Variable                = "$esc[38;2;114;28;197m"
  ListPredictionSelected  = "$esc[48;2;157;210;176m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;157;210;176m" + "$esc[38;2;24;24;17m"
}