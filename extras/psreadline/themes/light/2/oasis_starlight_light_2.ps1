# extras/psreadline/themes/light/2/oasis_starlight_light_2.ps1
## name: Oasis Starlight Light 2
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;118;75;51m"
  Comment                 = "$esc[38;2;100;116;137m"
  ContinuationPrompt      = "$esc[38;2;108;115;126m"
  Default                 = "$esc[38;2;29;29;20m"
  Emphasis                = "$esc[38;2;163;5;5m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;138;146;148m"
  Keyword                 = "$esc[38;2;121;111;49m"
  ListPrediction          = "$esc[38;2;138;146;148m"
  ListPredictionTooltip   = "$esc[38;2;138;146;148m"
  Member                  = "$esc[38;2;42;111;138m"
  Number                  = "$esc[38;2;172;87;19m"
  Operator                = "$esc[38;2;105;99;47m"
  Parameter               = "$esc[38;2;60;116;55m"
  String                  = "$esc[38;2;171;19;25m"
  Type                    = "$esc[38;2;57;114;97m"
  Variable                = "$esc[38;2;129;57;207m"
  ListPredictionSelected  = "$esc[48;2;231;221;202m" + "$esc[38;2;29;29;20m"
  Selection               = "$esc[48;2;231;221;202m" + "$esc[38;2;29;29;20m"
}