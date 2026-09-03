# extras/psreadline/themes/.../oasis_midnight_light_5.ps1
# name: Oasis Midnight Light 5
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;91;84;36m"
    Comment = "`e[3;38;2;78;88;102m"
    ContinuationPrompt = "`e[38;2;81;89;95m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;41;102;36m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;110;115;119m"
    Keyword = "`e[38;2;76;72;41m"
    ListPrediction = "`e[38;2;99;0;0m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;81;89;95m"
    Member = "`e[38;2;81;53;35m"
    Number = "`e[38;2;131;66;14m"
    Operator = "`e[38;2;77;72;35m"
    Parameter = "`e[38;2;45;86;41m"
    Selection = "`e[7m"
    String = "`e[38;2;121;13;17m"
    Type = "`e[38;2;42;85;72m"
    Variable = "`e[38;2;31;83;104m"
}