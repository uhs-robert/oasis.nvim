# extras/psreadline/themes/.../oasis_rose_light_2.ps1
# name: Oasis Rose Light 2
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;170;60;104m"
    Comment = "`e[3;38;2;126;96;111m"
    ContinuationPrompt = "`e[38;2;116;100;109m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;49;120;99m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;139;131;135m"
    Keyword = "`e[38;2;144;57;92m"
    ListPrediction = "`e[38;2;46;84;47m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;116;100;109m"
    Member = "`e[38;2;104;67;45m"
    Number = "`e[38;2;156;79;17m"
    Operator = "`e[38;2;144;57;92m"
    Parameter = "`e[38;2;54;105;49m"
    Selection = "`e[7m"
    String = "`e[38;2;153;17;22m"
    Type = "`e[38;2;51;103;88m"
    Variable = "`e[38;2;38;100;125m"
}