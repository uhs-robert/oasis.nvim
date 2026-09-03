# extras/psreadline/themes/light/1/oasis_sol_light_1.ps1
## name: Oasis Sol Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;101;65;44m"
  Comment                 = "$esc[38;2;120;96;94m"
  ContinuationPrompt      = "$esc[38;2;115;98;95m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;56;128;50m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;130;130;130m"
  Keyword                 = "$esc[38;2;185;41;44m"
  ListPrediction          = "$esc[38;2;130;130;130m"
  ListPredictionTooltip   = "$esc[38;2;130;130;130m"
  Member                  = "$esc[38;2;37;98;122m"
  Number                  = "$esc[38;2;151;78;17m"
  Operator                = "$esc[38;2;164;33;37m"
  Parameter               = "$esc[38;2;52;102;49m"
  String                  = "$esc[38;2;80;74;32m"
  Type                    = "$esc[38;2;50;100;85m"
  Variable                = "$esc[38;2;119;29;204m"
  ListPredictionSelected  = "$esc[48;2;238;170;170m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;238;170;170m" + "$esc[38;2;24;24;17m"
}