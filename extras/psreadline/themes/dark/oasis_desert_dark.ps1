# extras/psreadline/themes/.../oasis_desert_dark.ps1
# name: Oasis Desert Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;240;230;140m"
    Comment = "`e[3;38;2;148;143;122m"
    ContinuationPrompt = "`e[38;2;119;114;95m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;127;207;120m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;135;132;120m"
    Keyword = "`e[38;2;189;183;107m"
    ListPrediction = "`e[38;2;255;121;121m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;119;114;95m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;163;77m"
    Operator = "`e[38;2;216;207;127m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}