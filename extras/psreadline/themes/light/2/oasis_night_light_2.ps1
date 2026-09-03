# extras/psreadline/themes/.../oasis_night_light_2.ps1
# name: Oasis Night Light 2
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;113;103;45m"
    Comment = "`e[3;38;2;93;108;128m"
    ContinuationPrompt = "`e[38;2;98;109;118m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;163;5;5m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;132;136;142m"
    Keyword = "`e[38;2;96;91;51m"
    ListPrediction = "`e[38;2;112;103;18m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;98;109;118m"
    Member = "`e[38;2;108;69;47m"
    Number = "`e[38;2;160;81;17m"
    Operator = "`e[38;2;97;91;44m"
    Parameter = "`e[38;2;56;108;51m"
    Selection = "`e[7m"
    String = "`e[38;2;157;17;23m"
    Type = "`e[38;2;53;106;90m"
    Variable = "`e[38;2;40;103;128m"
}