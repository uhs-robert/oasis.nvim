# extras/psreadline/themes/light/5/oasis_abyss_light_5.ps1
## name: Oasis Abyss Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;78;50;34m"
  Comment                 = "$esc[38;2;88;85;75m"
  ContinuationPrompt      = "$esc[38;2;88;85;78m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;41;102;36m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;113;112;106m"
  Keyword                 = "$esc[38;2;89;82;35m"
  ListPrediction          = "$esc[38;2;113;112;106m"
  ListPredictionTooltip   = "$esc[38;2;113;112;106m"
  Member                  = "$esc[38;2;30;80;100m"
  Number                  = "$esc[38;2;127;64;14m"
  Operator                = "$esc[38;2;74;70;34m"
  Parameter               = "$esc[38;2;43;84;39m"
  String                  = "$esc[38;2;116;13;17m"
  Type                    = "$esc[38;2;41;82;70m"
  Variable                = "$esc[38;2;97;23;167m"
  ListPredictionSelected  = "$esc[48;2;170;170;170m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;170;170;170m" + "$esc[38;2;24;24;17m"
}