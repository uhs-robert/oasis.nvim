# extras/psreadline/themes/light/1/oasis_twilight_light_1.ps1
## name: Oasis Twilight Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;92;84;31m"
  Comment                 = "$esc[38;2;118;108;141m"
  ContinuationPrompt      = "$esc[38;2;116;110;130m"
  Default                 = "$esc[38;2;27;27;19m"
  Emphasis                = "$esc[38;2;152;140;26m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;143;141;149m"
  Keyword                 = "$esc[38;2;190;67;32m"
  ListPrediction          = "$esc[38;2;143;141;149m"
  ListPredictionTooltip   = "$esc[38;2;143;141;149m"
  Member                  = "$esc[38;2;41;109;136m"
  Number                  = "$esc[38;2;168;86;18m"
  Operator                = "$esc[38;2;169;59;28m"
  Parameter               = "$esc[38;2;59;114;54m"
  String                  = "$esc[38;2;168;18;24m"
  Type                    = "$esc[38;2;55;112;96m"
  Variable                = "$esc[38;2;133;36;224m"
  ListPredictionSelected  = "$esc[48;2;219;199;235m" + "$esc[38;2;27;27;19m"
  Selection               = "$esc[48;2;219;199;235m" + "$esc[38;2;27;27;19m"
}