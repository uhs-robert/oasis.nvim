# extras/psreadline/themes/light/3/oasis_desert_light_3.ps1
## name: Oasis Desert Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;108;70;47m"
  Comment                 = "$esc[38;2;111;107;96m"
  ContinuationPrompt      = "$esc[38;2;110;107;98m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;49;115;43m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;138;136;130m"
  Keyword                 = "$esc[38;2;116;103;28m"
  ListPrediction          = "$esc[38;2;138;136;130m"
  ListPredictionTooltip   = "$esc[38;2;138;136;130m"
  Member                  = "$esc[38;2;39;103;131m"
  Number                  = "$esc[38;2;160;82;17m"
  Operator                = "$esc[38;2;99;92;40m"
  Parameter               = "$esc[38;2;56;108;51m"
  String                  = "$esc[38;2;158;17;22m"
  Type                    = "$esc[38;2;53;106;91m"
  Variable                = "$esc[38;2;126;31;216m"
  ListPredictionSelected  = "$esc[48;2;231;219;158m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;231;219;158m" + "$esc[38;2;24;24;17m"
}