# extras/psreadline/themes/light/5/oasis_moonlight_light_5.ps1
## name: Oasis Moonlight Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;91;59;40m"
  Comment                 = "$esc[38;2;84;96;111m"
  ContinuationPrompt      = "$esc[38;2;87;96;102m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;138;0;0m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;118;123;127m"
  Keyword                 = "$esc[38;2;99;91;40m"
  ListPrediction          = "$esc[38;2;118;123;127m"
  ListPredictionTooltip   = "$esc[38;2;118;123;127m"
  Member                  = "$esc[38;2;34;90;113m"
  Number                  = "$esc[38;2;142;72;15m"
  Operator                = "$esc[38;2;85;79;39m"
  Parameter               = "$esc[38;2;49;94;44m"
  String                  = "$esc[38;2;134;15;19m"
  Type                    = "$esc[38;2;46;92;79m"
  Variable                = "$esc[38;2;109;26;188m"
  ListPredictionSelected  = "$esc[48;2;198;190;158m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;198;190;158m" + "$esc[38;2;24;24;17m"
}