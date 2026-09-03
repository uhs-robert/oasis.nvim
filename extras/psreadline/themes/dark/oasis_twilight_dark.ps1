# extras/psreadline/themes/.../oasis_twilight_dark.ps1
# name: Oasis Twilight Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;249;175;150m"
    Comment = "`e[3;38;2;139;128;170m"
    ContinuationPrompt = "`e[38;2;113;96;154m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;240;230;140m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;127;122;141m"
    Keyword = "`e[38;2;226;142;111m"
    ListPrediction = "`e[38;2;210;173;255m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;113;96;154m"
    Member = "`e[38;2;240;230;140m"
    Number = "`e[38;2;255;163;77m"
    Operator = "`e[38;2;249;175;150m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;124;205;181m"
    Variable = "`e[38;2;146;211;237m"
}