# extras/psreadline/themes/.../oasis_cactus_light_1.ps1
# name: Oasis Cactus Light 1
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;70;121;73m"
    Comment = "`e[3;38;2;96;120;99m"
    ContinuationPrompt = "`e[38;2;105;117;107m"
    Default = "`e[38;2;28;28;19m"
    Emphasis = "`e[38;2;171;7;7m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;138;145;140m"
    Keyword = "`e[38;2;63;107;66m"
    ListPrediction = "`e[38;2;64;6;135m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;105;117;107m"
    Member = "`e[38;2;117;75;50m"
    Number = "`e[38;2;170;87;19m"
    Operator = "`e[38;2;62;107;64m"
    Parameter = "`e[38;2;133;96;19m"
    Selection = "`e[7m"
    String = "`e[38;2;170;19;24m"
    Type = "`e[38;2;56;113;96m"
    Variable = "`e[38;2;42;110;137m"
}