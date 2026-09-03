# extras/psreadline/themes/.../oasis_lagoon_light_2.ps1
# name: Oasis Lagoon Light 2
# author: uhs-robert

Set-PSReadLineOption -Colors @{
    Command = "`e[38;2;22;104;204m"
    Comment = "`e[3;38;2;82;114;134m"
    ContinuationPrompt = "`e[38;2;92;113;126m"
    Default = "`e[38;2;24;24;17m"
    Emphasis = "`e[38;2;163;5;5m"
    Error = "`e[38;2;112;24;24m"
    InlinePrediction = "`e[3;38;2;134;140;144m"
    Keyword = "`e[38;2;19;96;161m"
    ListPrediction = "`e[38;2;120;65;10m"
    ListPredictionSelected = "`e[7m"
    ListPredictionTooltip = "`e[38;2;92;113;126m"
    Member = "`e[38;2;112;72;49m"
    Number = "`e[38;2;165;84;18m"
    Operator = "`e[38;2;20;92;180m"
    Parameter = "`e[38;2;58;111;52m"
    Selection = "`e[7m"
    String = "`e[38;2;163;18;24m"
    Type = "`e[38;2;111;100;29m"
    Variable = "`e[38;2;39;106;132m"
}