# extras/psreadline/themes/.../oasis_cactus_dark.ps1
# name: Oasis Cactus Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;174;214;176m"
    Comment = "`e[3;38;2;105;149;109m"
    ContinuationPrompt = "`e[38;2;91;115;96m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;255;160;160m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;116;132;119m"
    Keyword = "`e[38;2;147;199;149m"
    ListPrediction = "`e[38;2;210;173;255m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;91;115;96m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;163;77m"
    Operator = "`e[38;2;167;211;169m"
    Parameter = "`e[38;2;255;208;92m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}