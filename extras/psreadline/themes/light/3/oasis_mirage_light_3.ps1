# extras/psreadline/themes/light/3/oasis_mirage_light_3.ps1
## name: Oasis Mirage Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;108;70;47m"
  Comment                 = "$esc[38;2;69;116;107m"
  ContinuationPrompt      = "$esc[38;2;96;110;109m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;72;3;155m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;130;138;137m"
  Keyword                 = "$esc[38;2;54;114;97m"
  ListPrediction          = "$esc[38;2;130;138;137m"
  ListPredictionTooltip   = "$esc[38;2;130;138;137m"
  Member                  = "$esc[38;2;39;103;131m"
  Number                  = "$esc[38;2;160;82;17m"
  Operator                = "$esc[38;2;47;100;84m"
  Parameter               = "$esc[38;2;56;108;51m"
  String                  = "$esc[38;2;158;17;22m"
  Type                    = "$esc[38;2;108;97;29m"
  Variable                = "$esc[38;2;125;31;217m"
  ListPredictionSelected  = "$esc[48;2;170;227;220m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;170;227;220m" + "$esc[38;2;24;24;17m"
}