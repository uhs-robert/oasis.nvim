# extras/psreadline/themes/light/3/oasis_starlight_light_3.ps1
## name: Oasis Starlight Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;112;73;49m"
  Comment                 = "$esc[38;2;97;112;133m"
  ContinuationPrompt      = "$esc[38;2;104;112;122m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;155;3;3m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;134;141;144m"
  Keyword                 = "$esc[38;2;116;107;46m"
  ListPrediction          = "$esc[38;2;134;141;144m"
  ListPredictionTooltip   = "$esc[38;2;134;141;144m"
  Member                  = "$esc[38;2;41;107;135m"
  Number                  = "$esc[38;2;165;85;18m"
  Operator                = "$esc[38;2;101;95;46m"
  Parameter               = "$esc[38;2;58;112;53m"
  String                  = "$esc[38;2;164;18;23m"
  Type                    = "$esc[38;2;54;110;94m"
  Variable                = "$esc[38;2;126;51;205m"
  ListPredictionSelected  = "$esc[48;2;225;216;193m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;225;216;193m" + "$esc[38;2;24;24;17m"
}