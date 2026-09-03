# extras/psreadline/themes/light/1/oasis_mirage_light_1.ps1
## name: Oasis Mirage Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;117;75;50m"
  Comment                 = "$esc[38;2;75;123;115m"
  ContinuationPrompt      = "$esc[38;2;103;117;116m"
  Default                 = "$esc[38;2;28;28;20m"
  Emphasis                = "$esc[38;2;81;7;171m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;139;145;145m"
  Keyword                 = "$esc[38;2;56;121;104m"
  ListPrediction          = "$esc[38;2;139;145;145m"
  ListPredictionTooltip   = "$esc[38;2;139;145;145m"
  Member                  = "$esc[38;2;42;111;138m"
  Number                  = "$esc[38;2;170;87;19m"
  Operator                = "$esc[38;2;51;107;90m"
  Parameter               = "$esc[38;2;59;115;55m"
  String                  = "$esc[38;2;170;19;24m"
  Type                    = "$esc[38;2;115;104;30m"
  Variable                = "$esc[38;2;134;39;225m"
  ListPredictionSelected  = "$esc[48;2;192;235;228m" + "$esc[38;2;28;28;20m"
  Selection               = "$esc[48;2;192;235;228m" + "$esc[38;2;28;28;20m"
}