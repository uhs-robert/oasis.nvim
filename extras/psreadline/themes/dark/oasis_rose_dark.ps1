# extras/psreadline/themes/.../oasis_rose_dark.ps1
# name: Oasis Rose Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;236;181;203m"
    Comment = "`e[3;38;2;168;122;145m"
    ContinuationPrompt = "`e[38;2;129;97;117m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;124;205;181m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;140;125;134m"
    Keyword = "`e[38;2;223;147;177m"
    ListPrediction = "`e[38;2;147;199;149m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;129;97;117m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;150;51m"
    Operator = "`e[38;2;223;147;177m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}