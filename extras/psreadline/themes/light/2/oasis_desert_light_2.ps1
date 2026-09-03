# extras/psreadline/themes/light/2/oasis_desert_light_2.ps1
## name: Oasis Desert Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;112;72;49m"
  Comment                 = "$esc[38;2;114;111;99m"
  ContinuationPrompt      = "$esc[38;2;113;111;102m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;53;122;47m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;141;140;133m"
  Keyword                 = "$esc[38;2;119;107;29m"
  ListPrediction          = "$esc[38;2;141;140;133m"
  ListPredictionTooltip   = "$esc[38;2;141;140;133m"
  Member                  = "$esc[38;2;41;107;133m"
  Number                  = "$esc[38;2;165;84;18m"
  Operator                = "$esc[38;2;103;94;41m"
  Parameter               = "$esc[38;2;58;111;53m"
  String                  = "$esc[38;2;163;18;24m"
  Type                    = "$esc[38;2;55;109;93m"
  Variable                = "$esc[38;2;130;32;223m"
  ListPredictionSelected  = "$esc[48;2;234;224;170m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;234;224;170m" + "$esc[38;2;24;24;17m"
}