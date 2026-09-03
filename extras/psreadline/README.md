# PSReadLine Setup

[PSReadLine](https://github.com/PowerShell/PSReadLine) provides syntax highlighting and prediction for PowerShell's command line.

> [!NOTE]
> These scripts use the `` `e `` escape character, which requires PowerShell 6+ (`pwsh`, including PowerShell 7). Windows PowerShell 5.1's parser does not support `` `e `` — on 5.1 replace it with `$([char]27)` in the script before sourcing it, or install PowerShell 7.

1. Pick the `dark` folder, or the `light/<1-5>` folder matching the intensity you use elsewhere (e.g. your Windows Terminal scheme), and copy the `.ps1` file you want.
2. Dot-source it from your `$PROFILE`:

```powershell
. path\to\oasis_lagoon_dark.ps1
```

3. Or run it once in your current session to try it out:

```powershell
& path\to\oasis_lagoon_dark.ps1
```
