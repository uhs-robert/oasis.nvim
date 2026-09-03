# extras/psreadline/themes/.../oasis_night_light_3.ps1
# name: Oasis Night Light 3
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;104;96;42m"
    Comment = "`e[3;38;2;87;101;119m"
    ContinuationPrompt = "`e[38;2;92;101;110m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;155;3;3m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;124;129;134m"
    Keyword = "`e[38;2;88;84;47m"
    ListPrediction = "`e[38;2;104;95;16m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;92;101;110m"
    Member = "`e[38;2;98;63;43m"
    Number = "`e[38;2;148;76;16m"
    Operator = "`e[38;2;89;85;41m"
    Parameter = "`e[38;2;52;100;47m"
    Selection = "`e[7m"
    String = "`e[38;2;144;16;20m"
    Type = "`e[38;2;48;98;84m"
    Variable = "`e[38;2;36;95;121m"
}