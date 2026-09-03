# extras/psreadline/themes/.../oasis_midnight_light_1.ps1
# name: Oasis Midnight Light 1
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;115;105;46m"
    Comment = "`e[3;38;2;98;110;129m"
    ContinuationPrompt = "`e[38;2;100;110;119m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;56;128;50m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;133;139;143m"
    Keyword = "`e[38;2;99;93;52m"
    ListPrediction = "`e[38;2;135;6;6m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;100;110;119m"
    Member = "`e[38;2;110;71;47m"
    Number = "`e[38;2;162;83;18m"
    Operator = "`e[38;2;99;93;45m"
    Parameter = "`e[38;2;56;110;52m"
    Selection = "`e[7m"
    String = "`e[38;2;160;18;23m"
    Type = "`e[38;2;53;108;92m"
    Variable = "`e[38;2;40;105;131m"
}