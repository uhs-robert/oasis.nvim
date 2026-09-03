# extras/psreadline/themes/light/2/oasis_dune_light_2.ps1
## name: Oasis Dune Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;112;72;49m"
  Comment                 = "$esc[38;2;121;108;98m"
  ContinuationPrompt      = "$esc[38;2;119;108;99m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;50;118;99m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;144;139;134m"
  Keyword                 = "$esc[38;2;118;106;29m"
  ListPrediction          = "$esc[38;2;144;139;134m"
  ListPredictionTooltip   = "$esc[38;2;144;139;134m"
  Member                  = "$esc[38;2;41;106;132m"
  Number                  = "$esc[38;2;165;84;18m"
  Operator                = "$esc[38;2;102;94;41m"
  Parameter               = "$esc[38;2;58;111;52m"
  String                  = "$esc[38;2;163;18;24m"
  Type                    = "$esc[38;2;55;109;93m"
  Variable                = "$esc[38;2;129;32;222m"
  ListPredictionSelected  = "$esc[48;2;239;215;174m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;239;215;174m" + "$esc[38;2;24;24;17m"
}