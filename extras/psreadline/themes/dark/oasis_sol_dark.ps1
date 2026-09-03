# extras/psreadline/themes/.../oasis_sol_dark.ps1
# name: Oasis Sol Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;243;148;147m"
    Comment = "`e[3;38;2;162;125;120m"
    ContinuationPrompt = "`e[38;2;131;97;91m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;127;207;120m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;126;126;126m"
    Keyword = "`e[38;2;255;128;128m"
    ListPrediction = "`e[38;2;248;180;113m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;131;97;91m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;150;51m"
    Operator = "`e[38;2;245;139;139m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;216;207;127m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}