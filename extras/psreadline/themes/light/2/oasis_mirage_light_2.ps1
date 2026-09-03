# extras/psreadline/themes/.../oasis_mirage_light_2.ps1
# name: Oasis Mirage Light 2
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;55;117;100m"
    Comment = "`e[3;38;2;72;120;111m"
    ContinuationPrompt = "`e[38;2;100;114;113m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;76;5;163m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;134;142;142m"
    Keyword = "`e[38;2;53;103;90m"
    ListPrediction = "`e[38;2;120;65;10m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;100;114;113m"
    Member = "`e[38;2;113;72;49m"
    Number = "`e[38;2;166;84;18m"
    Operator = "`e[38;2;49;103;87m"
    Parameter = "`e[38;2;58;112;53m"
    Selection = "`e[7m"
    String = "`e[38;2;164;18;24m"
    Type = "`e[38;2;111;100;29m"
    Variable = "`e[38;2;41;107;133m"
}