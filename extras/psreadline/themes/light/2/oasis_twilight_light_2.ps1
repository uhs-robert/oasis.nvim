# extras/psreadline/themes/light/2/oasis_twilight_light_2.ps1
## name: Oasis Twilight Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;86;79;29m"
  Comment                 = "$esc[38;2;112;103;133m"
  ContinuationPrompt      = "$esc[38;2;110;105;123m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;145;133;23m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;138;135;144m"
  Keyword                 = "$esc[38;2;181;64;31m"
  ListPrediction          = "$esc[38;2;138;135;144m"
  ListPredictionTooltip   = "$esc[38;2;138;135;144m"
  Member                  = "$esc[38;2;39;104;130m"
  Number                  = "$esc[38;2;161;82;18m"
  Operator                = "$esc[38;2;160;56;27m"
  Parameter               = "$esc[38;2;56;108;51m"
  String                  = "$esc[38;2;158;17;23m"
  Type                    = "$esc[38;2;53;106;90m"
  Variable                = "$esc[38;2;126;31;217m"
  ListPredictionSelected  = "$esc[48;2;210;188;233m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;210;188;233m" + "$esc[38;2;24;24;17m"
}