# extras/psreadline/themes/.../oasis_lagoon_light_3.ps1
# name: Oasis Lagoon Light 3
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;21;99;193m"
    Comment = "`e[3;38;2;80;109;129m"
    ContinuationPrompt = "`e[38;2;88;108;120m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;155;3;3m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;128;135;138m"
    Keyword = "`e[38;2;18;90;153m"
    ListPrediction = "`e[38;2;112;60;8m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;88;108;120m"
    Member = "`e[38;2;105;68;46m"
    Number = "`e[38;2;156;80;17m"
    Operator = "`e[38;2;18;87;169m"
    Parameter = "`e[38;2;54;106;50m"
    Selection = "`e[7m"
    String = "`e[38;2;154;17;21m"
    Type = "`e[38;2;106;94;28m"
    Variable = "`e[38;2;36;101;126m"
}