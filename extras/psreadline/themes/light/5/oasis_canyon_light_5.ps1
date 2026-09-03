# extras/psreadline/themes/light/5/oasis_canyon_light_5.ps1
## name: Oasis Canyon Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;64;58;21m"
  Comment                 = "$esc[38;2;108;79;67m"
  ContinuationPrompt      = "$esc[38;2;99;82;74m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;138;0;0m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;117;111;108m"
  Keyword                 = "$esc[38;2;143;51;24m"
  ListPrediction          = "$esc[38;2;117;111;108m"
  ListPredictionTooltip   = "$esc[38;2;117;111;108m"
  Member                  = "$esc[38;2;30;81;101m"
  Number                  = "$esc[38;2;127;64;14m"
  Operator                = "$esc[38;2;123;43;20m"
  Parameter               = "$esc[38;2;44;84;40m"
  String                  = "$esc[38;2;117;13;17m"
  Type                    = "$esc[38;2;41;83;71m"
  Variable                = "$esc[38;2;97;24;168m"
  ListPredictionSelected  = "$esc[48;2;220;163;116m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;220;163;116m" + "$esc[38;2;24;24;17m"
}