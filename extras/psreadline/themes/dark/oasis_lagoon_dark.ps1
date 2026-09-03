# extras/psreadline/themes/.../oasis_lagoon_dark.ps1
# name: Oasis Lagoon Dark
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;113;184;255m"
    Comment = "`e[3;38;2;77;136;167m"
    ContinuationPrompt = "`e[38;2;59;106;135m"
    Default = "`e[38;2;245;245;220m"
    Emphasis = "`e[38;2;255;160;160m"
    Error = "`e[38;2;255;160;160m"
    InlinePrediction = "`e[3;38;2;114;127;134m"
    Keyword = "`e[38;2;58;172;253m"
    ListPrediction = "`e[38;2;248;180;113m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;59;106;135m"
    Member = "`e[38;2;233;192;165m"
    Number = "`e[38;2;255;163;77m"
    Operator = "`e[38;2;129;192;255m"
    Parameter = "`e[38;2;127;207;120m"
    Selection = "`e[7m"
    String = "`e[38;2;255;160;160m"
    Type = "`e[38;2;243;234;159m"
    Variable = "`e[38;2;165;220;241m"
}