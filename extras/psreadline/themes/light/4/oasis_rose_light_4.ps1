# extras/psreadline/themes/.../oasis_rose_light_4.ps1
# name: Oasis Rose Light 4
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;150;54;92m"
    Comment = "`e[3;38;2;113;85;99m"
    ContinuationPrompt = "`e[38;2;103;89;97m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;42;106;87m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;124;118;122m"
    Keyword = "`e[38;2;126;50;79m"
    ListPrediction = "`e[38;2;38;72;39m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;103;89;97m"
    Member = "`e[38;2;89;57;39m"
    Number = "`e[38;2;138;70;15m"
    Operator = "`e[38;2;126;50;79m"
    Parameter = "`e[38;2;47;92;44m"
    Selection = "`e[7m"
    String = "`e[38;2;131;14;18m"
    Type = "`e[38;2;45;90;76m"
    Variable = "`e[38;2;34;88;111m"
}