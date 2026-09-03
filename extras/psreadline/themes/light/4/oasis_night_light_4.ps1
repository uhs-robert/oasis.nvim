# extras/psreadline/themes/.../oasis_night_light_4.ps1
# name: Oasis Night Light 4
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;99;91;39m"
    Comment = "`e[3;38;2;82;96;113m"
    ContinuationPrompt = "`e[38;2;87;95;103m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;146;1;1m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;118;123;127m"
    Keyword = "`e[38;2;84;79;44m"
    ListPrediction = "`e[38;2;96;88;13m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;87;95;103m"
    Member = "`e[38;2;91;58;40m"
    Number = "`e[38;2;140;72;15m"
    Operator = "`e[38;2;84;79;38m"
    Parameter = "`e[38;2;48;94;45m"
    Selection = "`e[7m"
    String = "`e[38;2;134;15;19m"
    Type = "`e[38;2;46;92;78m"
    Variable = "`e[38;2;34;90;113m"
}