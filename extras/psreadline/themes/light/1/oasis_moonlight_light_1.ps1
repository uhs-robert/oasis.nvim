# extras/psreadline/themes/light/1/oasis_moonlight_light_1.ps1
## name: Oasis Moonlight Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;113;72;49m"
  Comment                 = "$esc[38;2;100;111;131m"
  ContinuationPrompt      = "$esc[38;2;102;112;120m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;171;7;7m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;136;140;145m"
  Keyword                 = "$esc[38;2;117;107;47m"
  ListPrediction          = "$esc[38;2;136;140;145m"
  ListPredictionTooltip   = "$esc[38;2;136;140;145m"
  Member                  = "$esc[38;2;41;107;133m"
  Number                  = "$esc[38;2;165;85;18m"
  Operator                = "$esc[38;2;101;95;45m"
  Parameter               = "$esc[38;2;57;112;53m"
  String                  = "$esc[38;2;164;18;23m"
  Type                    = "$esc[38;2;54;110;94m"
  Variable                = "$esc[38;2;130;32;224m"
  ListPredictionSelected  = "$esc[48;2;220;217;197m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;220;217;197m" + "$esc[38;2;24;24;17m"
}