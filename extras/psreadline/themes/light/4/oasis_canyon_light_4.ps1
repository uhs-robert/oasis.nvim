# extras/psreadline/themes/light/4/oasis_canyon_light_4.ps1
## name: Oasis Canyon Light 4
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;68;62;23m"
  Comment                 = "$esc[38;2;114;83;70m"
  ContinuationPrompt      = "$esc[38;2;104;87;78m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;146;1;1m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;121;116;113m"
  Keyword                 = "$esc[38;2;151;54;26m"
  ListPrediction          = "$esc[38;2;121;116;113m"
  ListPredictionTooltip   = "$esc[38;2;121;116;113m"
  Member                  = "$esc[38;2;33;85;107m"
  Number                  = "$esc[38;2;134;68;15m"
  Operator                = "$esc[38;2;131;47;23m"
  Parameter               = "$esc[38;2;46;89;43m"
  String                  = "$esc[38;2;126;14;18m"
  Type                    = "$esc[38;2;43;88;74m"
  Variable                = "$esc[38;2;104;26;177m"
  ListPredictionSelected  = "$esc[48;2;223;171;128m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;223;171;128m" + "$esc[38;2;24;24;17m"
}