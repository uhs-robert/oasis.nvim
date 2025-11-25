# Termux Setup

1.  Copy the contents of a generated theme file (e.g., `oasis_lagoon.properties`) into your Termux `colors.properties` file. The typical location is `~/.termux/colors.properties`.
2.  If the file or directory doesn't exist, create it.
3.  Reload the Termux session for the changes to take effect by running `termux-reload-settings`.

### Example

```sh
# Create directory if it doesn't exist
mkdir -p ~/.termux

# Copy the desired theme to colors.properties
cp extras/termux/oasis_lagoon.properties ~/.termux/colors.properties

# Reload Termux settings
termux-reload-settings
```
