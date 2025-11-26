# Yazi Setup

This directory provides Oasis color themes for Yazi.

## Installation

### Copy to Yazi Config

Create the Yazi flavors directory if it doesn't exist:

```bash
mkdir -p ~/.config/yazi/flavors
```

Copy your desired theme file to Yazi's flavors directory. For example, to use the Lagoon theme:

```bash
cp extras/yazi/flavors/oasis-lagoon.yazi ~/.config/yazi/flavors/
```

### Configure Yazi

Edit your `~/.config/yazi/theme.toml` to import the Oasis theme:

```toml
[flavor]
dark = "oasis-lagoon"
light = "oasis-dawn"
```

> [!NOTE]
> Yazi uses your terminal background.
>
> You should set it to the relevant background for your theme.
