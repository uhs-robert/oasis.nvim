# extras/psreadline/themes/.../oasis_midnight_dark.ps1
# name: Oasis Midnight Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;216;207;127m"
    Comment = "`e[3;38;2;105;128;157m"
    ContinuationPrompt = "`e[38;2;78;101;120m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;127;207;120m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;111;122;131m"
    Keyword = "`e[38;2;189;183;107m"
    ListPrediction = "`e[38;2;255;121;121m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;78;101;120m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;163;77m"
    Operator = "`e[38;2;205;198;115m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}