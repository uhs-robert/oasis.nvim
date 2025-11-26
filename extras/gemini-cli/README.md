# Gemini CLI Setup

Gemini CLI themes are stored as JSON files in, well, any directory. There is no official place for themes yet. I personally put them in `.gemini`.

### Installation

```bash
# Create themes directory somewhere you'll remember. I use this one.
mkdir -p ~/.gemini/themes/

# Copy a theme (example: lagoon)
cp oasis_lagoon.json ~/.gemini/themes/

# Or copy all themes
cp *.json ~/.gemini/themes/
```

### Usage

**Via gemini-cli command:**

In the [Gemini CLI configuration](https://geminicli.com/docs/get-started/configuration/#settings-files), set the `theme` field under `ui` to the location of the theme file.

```json
"ui": {
 "theme": "/path/to/your/theme/oasis_lagoon.json"
}
```

Reload Gemini CLI if it is running.

> [!IMPORTANT]
> You can't use `~/` in your path. It has to be the full path.
