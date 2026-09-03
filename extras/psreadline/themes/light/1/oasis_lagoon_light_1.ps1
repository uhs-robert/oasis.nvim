# extras/psreadline/themes/light/1/oasis_lagoon_light_1.ps1
## name: Oasis Lagoon Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;116;74;50m"
  Comment                 = "$esc[38;2;85;117;139m"
  ContinuationPrompt      = "$esc[38;2;96;117;129m"
  Default                 = "$esc[38;2;27;27;19m"
  Emphasis                = "$esc[38;2;171;7;7m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;139;144;147m"
  Keyword                 = "$esc[38;2;23;107;209m"
  ListPrediction          = "$esc[38;2;139;144;147m"
  ListPredictionTooltip   = "$esc[38;2;139;144;147m"
  Member                  = "$esc[38;2;40;110;136m"
  Number                  = "$esc[38;2;170;87;19m"
  Operator                = "$esc[38;2;20;95;185m"
  Parameter               = "$esc[38;2;59;115;55m"
  String                  = "$esc[38;2;169;18;24m"
  Type                    = "$esc[38;2;114;103;30m"
  Variable                = "$esc[38;2;134;38;225m"
  ListPredictionSelected  = "$esc[48;2;189;214;245m" + "$esc[38;2;27;27;19m"
  Selection               = "$esc[48;2;189;214;245m" + "$esc[38;2;27;27;19m"
}