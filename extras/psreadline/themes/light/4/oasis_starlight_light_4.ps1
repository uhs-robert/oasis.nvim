# extras/psreadline/themes/light/4/oasis_starlight_light_4.ps1
## name: Oasis Starlight Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;108;69;47m"
  Comment                 = "$esc[38;2;93;109;128m"
  ContinuationPrompt      = "$esc[38;2;101;108;117m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;146;1;1m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;130;138;139m"
  Keyword                 = "$esc[38;2;113;104;45m"
  ListPrediction          = "$esc[38;2;130;138;139m"
  ListPredictionTooltip   = "$esc[38;2;130;138;139m"
  Member                  = "$esc[38;2;39;103;130m"
  Number                  = "$esc[38;2;160;82;17m"
  Operator                = "$esc[38;2;97;92;44m"
  Parameter               = "$esc[38;2;55;108;52m"
  String                  = "$esc[38;2;158;17;22m"
  Type                    = "$esc[38;2;52;106;89m"
  Variable                = "$esc[38;2;121;48;199m"
  ListPredictionSelected  = "$esc[48;2;220;211;183m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;220;211;183m" + "$esc[38;2;24;24;17m"
}