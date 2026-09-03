# extras/psreadline/themes/light/4/oasis_midnight_light_4.ps1
## name: Oasis Midnight Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;89;57;39m"
  Comment                 = "$esc[38;2;83;94;111m"
  ContinuationPrompt      = "$esc[38;2;86;94;101m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;45;108;39m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;115;121;126m"
  Keyword                 = "$esc[38;2;98;90;39m"
  ListPrediction          = "$esc[38;2;115;121;126m"
  ListPredictionTooltip   = "$esc[38;2;115;121;126m"
  Member                  = "$esc[38;2;34;88;111m"
  Number                  = "$esc[38;2;138;71;15m"
  Operator                = "$esc[38;2;82;78;38m"
  Parameter               = "$esc[38;2;47;93;44m"
  String                  = "$esc[38;2;132;14;19m"
  Type                    = "$esc[38;2;45;91;77m"
  Variable                = "$esc[38;2;107;27;185m"
  ListPredictionSelected  = "$esc[48;2;169;181;203m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;169;181;203m" + "$esc[38;2;24;24;17m"
}