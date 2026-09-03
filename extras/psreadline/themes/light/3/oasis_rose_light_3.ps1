# extras/psreadline/themes/light/3/oasis_rose_light_3.ps1
## name: Oasis Rose Light 3
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;96;62;42m"
  Comment                 = "$esc[38;2;119;90;104m"
  ContinuationPrompt      = "$esc[38;2;108;95;103m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;45;113;93m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;132;124;129m"
  Keyword                 = "$esc[38;2;159;58;98m"
  ListPrediction          = "$esc[38;2;132;124;129m"
  ListPredictionTooltip   = "$esc[38;2;132;124;129m"
  Member                  = "$esc[38;2;36;94;119m"
  Number                  = "$esc[38;2;146;75;16m"
  Operator                = "$esc[38;2;135;54;86m"
  Parameter               = "$esc[38;2;51;98;47m"
  String                  = "$esc[38;2;142;15;20m"
  Type                    = "$esc[38;2;48;96;82m"
  Variable                = "$esc[38;2;115;28;196m"
  ListPredictionSelected  = "$esc[48;2;229;167;205m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;229;167;205m" + "$esc[38;2;24;24;17m"
}