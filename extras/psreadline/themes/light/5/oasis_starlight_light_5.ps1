# extras/psreadline/themes/light/5/oasis_starlight_light_5.ps1
## name: Oasis Starlight Light 5
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;102;66;45m"
  Comment                 = "$esc[38;2;90;104;123m"
  ContinuationPrompt      = "$esc[38;2;96;104;113m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;138;0;0m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;125;133;135m"
  Keyword                 = "$esc[38;2;108;100;43m"
  ListPrediction          = "$esc[38;2;125;133;135m"
  ListPredictionTooltip   = "$esc[38;2;125;133;135m"
  Member                  = "$esc[38;2;37;99;124m"
  Number                  = "$esc[38;2;154;78;17m"
  Operator                = "$esc[38;2;93;87;43m"
  Parameter               = "$esc[38;2;53;103;48m"
  String                  = "$esc[38;2;150;16;22m"
  Type                    = "$esc[38;2;51;101;87m"
  Variable                = "$esc[38;2;116;46;189m"
  ListPredictionSelected  = "$esc[48;2;215;203;172m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;215;203;172m" + "$esc[38;2;24;24;17m"
}