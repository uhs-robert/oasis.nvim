# extras/psreadline/themes/light/1/oasis_cactus_light_1.ps1
## name: Oasis Cactus Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;117;75;50m"
  Comment                 = "$esc[38;2;96;120;99m"
  ContinuationPrompt      = "$esc[38;2;105;117;107m"
  Default                 = "$esc[38;2;28;28;19m"
  Emphasis                = "$esc[38;2;171;7;7m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;138;145;140m"
  Keyword                 = "$esc[38;2;70;121;73m"
  ListPrediction          = "$esc[38;2;138;145;140m"
  ListPredictionTooltip   = "$esc[38;2;138;145;140m"
  Member                  = "$esc[38;2;42;110;137m"
  Number                  = "$esc[38;2;170;87;19m"
  Operator                = "$esc[38;2;62;107;64m"
  Parameter               = "$esc[38;2;133;96;19m"
  String                  = "$esc[38;2;170;19;24m"
  Type                    = "$esc[38;2;56;113;96m"
  Variable                = "$esc[38;2;134;39;225m"
  ListPredictionSelected  = "$esc[48;2;198;231;210m" + "$esc[38;2;28;28;19m"
  Selection               = "$esc[48;2;198;231;210m" + "$esc[38;2;28;28;19m"
}