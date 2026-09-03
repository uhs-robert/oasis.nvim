# extras/psreadline/themes/.../oasis_dune_dark.ps1
# name: Oasis Dune Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;240;230;140m"
    Comment = "`e[3;38;2;159;139;121m"
    ContinuationPrompt = "`e[38;2;130;109;90m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;105;195;170m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;142;131;122m"
    Keyword = "`e[38;2;189;183;107m"
    ListPrediction = "`e[38;2;216;154;114m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;130;109;90m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;163;77m"
    Operator = "`e[38;2;216;207;127m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;135;206;235m"
}