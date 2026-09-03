# extras/psreadline/themes/light/1/oasis_night_light_1.ps1
## name: Oasis Night Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;115;74;49m"
  Comment                 = "$esc[38;2;98;114;135m"
  ContinuationPrompt      = "$esc[38;2;104;114;123m"
  Default                 = "$esc[38;2;26;26;18m"
  Emphasis                = "$esc[38;2;171;7;7m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;138;143;147m"
  Keyword                 = "$esc[38;2;119;109;47m"
  ListPrediction          = "$esc[38;2;138;143;147m"
  ListPredictionTooltip   = "$esc[38;2;138;143;147m"
  Member                  = "$esc[38;2;41;109;136m"
  Number                  = "$esc[38;2;168;86;18m"
  Operator                = "$esc[38;2;102;97;46m"
  Parameter               = "$esc[38;2;58;114;54m"
  String                  = "$esc[38;2;167;18;24m"
  Type                    = "$esc[38;2;55;111;95m"
  Variable                = "$esc[38;2;132;36;224m"
  ListPredictionSelected  = "$esc[48;2;206;214;222m" + "$esc[38;2;26;26;18m"
  Selection               = "$esc[48;2;206;214;222m" + "$esc[38;2;26;26;18m"
}