# extras/psreadline/themes/.../oasis_midnight_light_2.ps1
# name: Oasis Midnight Light 2
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;109;100;44m"
    Comment = "`e[3;38;2;93;104;122m"
    ContinuationPrompt = "`e[38;2;96;105;112m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;53;122;47m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;127;133;137m"
    Keyword = "`e[38;2;93;88;49m"
    ListPrediction = "`e[38;2;126;4;4m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;96;105;112m"
    Member = "`e[38;2;103;66;45m"
    Number = "`e[38;2;155;79;17m"
    Operator = "`e[38;2;94;88;42m"
    Parameter = "`e[38;2;54;104;49m"
    Selection = "`e[7m"
    String = "`e[38;2;151;16;22m"
    Type = "`e[38;2;51;102;87m"
    Variable = "`e[38;2;38;99;124m"
}