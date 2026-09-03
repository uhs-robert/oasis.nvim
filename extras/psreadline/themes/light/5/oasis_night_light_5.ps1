# extras/psreadline/themes/.../oasis_night_light_5.ps1
# name: Oasis Night Light 5
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;94;87;38m"
    Comment = "`e[3;38;2;79;92;108m"
    ContinuationPrompt = "`e[38;2;83;91;100m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;138;0;0m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;113;118;122m"
    Keyword = "`e[38;2;79;75;42m"
    ListPrediction = "`e[38;2;88;80;11m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;83;91;100m"
    Member = "`e[38;2;85;55;37m"
    Number = "`e[38;2;135;68;15m"
    Operator = "`e[38;2;80;75;37m"
    Parameter = "`e[38;2;46;89;42m"
    Selection = "`e[7m"
    String = "`e[38;2;127;14;18m"
    Type = "`e[38;2;44;88;75m"
    Variable = "`e[38;2;32;86;107m"
}