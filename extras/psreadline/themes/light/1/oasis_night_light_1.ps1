# extras/psreadline/themes/.../oasis_night_light_1.ps1
# name: Oasis Night Light 1
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;119;109;47m"
    Comment = "`e[3;38;2;98;114;135m"
    ContinuationPrompt = "`e[38;2;104;114;123m"
    Default = "`e[38;2;26;26;18m"
    Emphasis = "`e[38;2;171;7;7m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;138;143;147m"
    Keyword = "`e[38;2;102;96;54m"
    ListPrediction = "`e[38;2;120;110;20m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;104;114;123m"
    Member = "`e[38;2;115;74;49m"
    Number = "`e[38;2;168;86;18m"
    Operator = "`e[38;2;102;97;46m"
    Parameter = "`e[38;2;58;114;54m"
    Selection = "`e[7m"
    String = "`e[38;2;167;18;24m"
    Type = "`e[38;2;55;111;95m"
    Variable = "`e[38;2;41;109;136m"
}