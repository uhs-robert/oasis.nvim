# extras/psreadline/themes/light/1/oasis_rose_light_1.ps1
## name: Oasis Rose Light 1
## author: uhs-robert

$esc = [char]0x1B

Set-PSReadLineOption -Colors @{
  Command                 = "$esc[38;2;112;72;48m"
  Comment                 = "$esc[38;2;133;102;116m"
  ContinuationPrompt      = "$esc[38;2;122;106;116m"
  Default                 = "$esc[38;2;24;24;17m"
  Emphasis                = "$esc[38;2;53;126;104m"
  Error                   = "$esc[38;2;112;24;24m"
  InlinePrediction        = "$esc[38;2;144;138;142m"
  Keyword                 = "$esc[38;2;179;64;110m"
  ListPrediction          = "$esc[38;2;144;138;142m"
  ListPredictionTooltip   = "$esc[38;2;144;138;142m"
  Member                  = "$esc[38;2;40;107;133m"
  Number                  = "$esc[38;2;164;84;18m"
  Operator                = "$esc[38;2;153;61;97m"
  Parameter               = "$esc[38;2;57;111;53m"
  String                  = "$esc[38;2;163;18;23m"
  Type                    = "$esc[38;2;54;109;93m"
  Variable                = "$esc[38;2;130;31;223m"
  ListPredictionSelected  = "$esc[48;2;236;191;217m" + "$esc[38;2;24;24;17m"
  Selection               = "$esc[48;2;236;191;217m" + "$esc[38;2;24;24;17m"
}