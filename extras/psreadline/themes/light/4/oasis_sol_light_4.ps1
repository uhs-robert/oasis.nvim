# extras/psreadline/themes/.../oasis_sol_light_4.ps1
# name: Oasis Sol Light 4
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;150;32;36m"
    Comment = "`e[3;38;2;96;78;75m"
    ContinuationPrompt = "`e[38;2;93;79;77m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;45;108;39m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;109;109;109m"
    Keyword = "`e[38;2;134;15;19m"
    ListPrediction = "`e[38;2;104;54;6m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;93;79;77m"
    Member = "`e[38;2;74;48;32m"
    Number = "`e[38;2;122;62;13m"
    Operator = "`e[38;2;129;26;29m"
    Parameter = "`e[38;2;41;81;39m"
    Selection = "`e[7m"
    String = "`e[38;2;59;54;23m"
    Type = "`e[38;2;39;79;67m"
    Variable = "`e[38;2;29;77;97m"
}