# extras/psreadline/themes/.../oasis_night_dark.ps1
# name: Oasis Night Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;216;207;127m"
    Comment = "`e[3;38;2;112;140;168m"
    ContinuationPrompt = "`e[38;2;83;107;131m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;255;160;160m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;114;123;133m"
    Keyword = "`e[38;2;189;183;107m"
    ListPrediction = "`e[38;2;240;230;140m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;83;107;131m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;150;51m"
    Operator = "`e[38;2;205;198;115m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}