# Kitty Theme Setup

1. Create `~/.config/kitty/themes`
2. Download theme file into `themes` directory
3. Include the theme in `~/.config/kitty/kitty.conf`

### Example

```ini
include themes/oasis_lagoon.conf
```

> [!TIP]
> You can quickly switch themes by changing the `include` line and reloading Kitty with `Ctrl+Shift+F5` or by running `kitty @ load-config` if remote control is enabled.
