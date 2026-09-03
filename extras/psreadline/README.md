# PSReadLine Setup

PSReadLine themes are PowerShell scripts that call `Set-PSReadLineOption -Colors @{ ... }` with 24-bit truecolor ANSI escapes for the exact Oasis palette.

> [!NOTE]
> These are truecolor escape sequences and require a truecolor-capable host — Windows Terminal qualifies, but the legacy `conhost` console does not. PSReadLine 2.x is required.

### Installation

Copy the `.ps1` file for the variant you want somewhere you'll remember, for example:

```powershell
Copy-Item themes\dark\oasis_mirage_dark.ps1 "$HOME\Documents\PowerShell\oasis_mirage_dark.ps1"
```

### Usage

Dot-source it from your `$PROFILE` so it loads on every new session:

```powershell
. "$HOME\Documents\PowerShell\oasis_mirage_dark.ps1"
```

Reload PowerShell (or re-dot-source the file) to apply it immediately.

### Theme Structure

- **Dark themes**: `themes/dark/oasis_<variant>_dark.ps1`
- **Light themes**: `themes/light/<intensity>/oasis_<variant>_light_<intensity>.ps1`
  - Intensity levels: `1` (lightest) to `5` (darkest)
