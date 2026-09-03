# extras/psreadline/themes/light/4/oasis_luna_light_4.ps1
## name: Oasis Luna Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;91;58;40m"
  Comment                 = "$esc[38;2;98;88;131m"
  ContinuationPrompt      = "$esc[38;2;94;92;110m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;19;104;129m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;122;120;131m"
  Keyword                 = "$esc[38;2;99;91;39m"
  ListPrediction          = "$esc[38;2;122;120;131m"
  ListPredictionTooltip   = "$esc[38;2;122;120;131m"
  Member                  = "$esc[38;2;34;89;113m"
  Number                  = "$esc[38;2;140;72;15m"
  Operator                = "$esc[38;2;84;79;38m"
  Parameter               = "$esc[38;2;48;94;45m"
  String                  = "$esc[38;2;134;15;19m"
  Type                    = "$esc[38;2;46;92;78m"
  Variable                = "$esc[38;2;109;27;186m"
  ListPredictionSelected  = "$esc[48;2;167;162;233m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;167;162;233m" + "$esc[38;2;24;24;17m"
}