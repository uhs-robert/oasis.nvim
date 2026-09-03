# extras/psreadline/themes/light/3/oasis_sol_light_3.ps1
## name: Oasis Sol Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;83;54;36m"
  Comment                 = "$esc[38;2;105;84;82m"
  ContinuationPrompt      = "$esc[38;2;100;86;84m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;49;115;43m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;116;116;116m"
  Keyword                 = "$esc[38;2;162;35;39m"
  ListPrediction          = "$esc[38;2;116;116;116m"
  ListPredictionTooltip   = "$esc[38;2;116;116;116m"
  Member                  = "$esc[38;2;32;84;106m"
  Number                  = "$esc[38;2;132;68;14m"
  Operator                = "$esc[38;2;142;27;32m"
  Parameter               = "$esc[38;2;45;88;42m"
  String                  = "$esc[38;2;66;61;27m"
  Type                    = "$esc[38;2;43;86;74m"
  Variable                = "$esc[38;2;102;25;175m"
  ListPredictionSelected  = "$esc[48;2;231;146;146m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;231;146;146m" + "$esc[38;2;24;24;17m"
}