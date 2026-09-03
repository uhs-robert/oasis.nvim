# extras/psreadline/themes/light/1/oasis_desert_light_1.ps1
## name: Oasis Desert Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;116;74;50m"
  Comment                 = "$esc[38;2;116;113;101m"
  ContinuationPrompt      = "$esc[38;2;115;113;103m"
  Default                 = "$esc[38;2;27;27;19m"
  Emphasis                = "$esc[38;2;56;128;50m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;144;143;137m"
  Keyword                 = "$esc[38;2;122;109;28m"
  ListPrediction          = "$esc[38;2;144;143;137m"
  ListPredictionTooltip   = "$esc[38;2;144;143;137m"
  Member                  = "$esc[38;2;41;109;136m"
  Number                  = "$esc[38;2;169;87;18m"
  Operator                = "$esc[38;2;106;97;42m"
  Parameter               = "$esc[38;2;59;114;55m"
  String                  = "$esc[38;2;168;18;24m"
  Type                    = "$esc[38;2;55;112;96m"
  Variable                = "$esc[38;2;133;37;224m"
  ListPredictionSelected  = "$esc[48;2;237;228;182m" + "$esc[38;2;27;27;19m"
  Selection               = "$esc[48;2;237;228;182m" + "$esc[38;2;27;27;19m"
}