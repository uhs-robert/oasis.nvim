# extras/psreadline/themes/light/1/oasis_starlight_light_1.ps1
## name: Oasis Starlight Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;118;76;51m"
  Comment                 = "$esc[38;2;100;117;138m"
  ContinuationPrompt      = "$esc[38;2;108;116;126m"
  Default                 = "$esc[38;2;30;30;20m"
  Emphasis                = "$esc[38;2;171;7;7m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;140;146;148m"
  Keyword                 = "$esc[38;2;121;111;49m"
  ListPrediction          = "$esc[38;2;140;146;148m"
  ListPredictionTooltip   = "$esc[38;2;140;146;148m"
  Member                  = "$esc[38;2;42;111;139m"
  Number                  = "$esc[38;2;172;88;19m"
  Operator                = "$esc[38;2;105;99;47m"
  Parameter               = "$esc[38;2;60;116;56m"
  String                  = "$esc[38;2;172;19;25m"
  Type                    = "$esc[38;2;56;114;97m"
  Variable                = "$esc[38;2;130;58;207m"
  ListPredictionSelected  = "$esc[48;2;230;225;204m" + "$esc[38;2;30;30;20m"
  Selection               = "$esc[48;2;230;225;204m" + "$esc[38;2;30;30;20m"
}