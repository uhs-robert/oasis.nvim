# extras/psreadline/themes/light/4/oasis_cactus_light_4.ps1
## name: Oasis Cactus Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;102;65;44m"
  Comment                 = "$esc[38;2;87;108;88m"
  ContinuationPrompt      = "$esc[38;2;94;105;96m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;146;1;1m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;124;133;126m"
  Keyword                 = "$esc[38;2;64;108;66m"
  ListPrediction          = "$esc[38;2;124;133;126m"
  ListPredictionTooltip   = "$esc[38;2;124;133;126m"
  Member                  = "$esc[38;2;38;98;123m"
  Number                  = "$esc[38;2;153;78;17m"
  Operator                = "$esc[38;2;54;95;57m"
  Parameter               = "$esc[38;2;119;86;17m"
  String                  = "$esc[38;2;149;16;21m"
  Type                    = "$esc[38;2;50;101;85m"
  Variable                = "$esc[38;2;119;30;205m"
  ListPredictionSelected  = "$esc[48;2;168;215;186m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;168;215;186m" + "$esc[38;2;24;24;17m"
}