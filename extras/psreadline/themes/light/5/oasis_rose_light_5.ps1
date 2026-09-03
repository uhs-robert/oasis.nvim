# extras/psreadline/themes/light/5/oasis_rose_light_5.ps1
## name: Oasis Rose Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;80;52;35m"
  Comment                 = "$esc[38;2;104;79;92m"
  ContinuationPrompt      = "$esc[38;2;95;83;91m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;38;100;81m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;119;111;116m"
  Keyword                 = "$esc[38;2;140;49;86m"
  ListPrediction          = "$esc[38;2;119;111;116m"
  ListPredictionTooltip   = "$esc[38;2;119;111;116m"
  Member                  = "$esc[38;2;30;82;102m"
  Number                  = "$esc[38;2;129;65;14m"
  Operator                = "$esc[38;2;116;46;74m"
  Parameter               = "$esc[38;2;44;85;40m"
  String                  = "$esc[38;2;119;13;17m"
  Type                    = "$esc[38;2;42;84;71m"
  Variable                = "$esc[38;2;98;24;170m"
  ListPredictionSelected  = "$esc[48;2;222;143;193m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;222;143;193m" + "$esc[38;2;24;24;17m"
}