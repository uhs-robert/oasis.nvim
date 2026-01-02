# Bat Setup

1. Create the themes directory:

   ```bash
   mkdir -p "$(bat --config-dir)/themes"
   ```

2. Copy your desired theme file(s):

   ```bash
   # Dark theme
   cp extras/bat/themes/dark/oasis_lagoon_dark.tmTheme "$(bat --config-dir)/themes/"

   # Light theme (intensity levels 1-5)
   cp extras/bat/themes/light/3/oasis_lagoon_light_3.tmTheme "$(bat --config-dir)/themes/"
   ```

3. Rebuild bat's cache:

   ```bash
   bat cache --build
   ```

4. Set your theme in `~/.config/bat/config`:

   ```bash
   --theme="oasis_lagoon_dark"
   ```

> [!TIP]
> Dark themes are in `themes/dark/`, light themes organized by intensity (1-5) in `themes/light/<intensity>/`

## Resources

- [bat documentation](https://github.com/sharkdp/bat#readme)
- [TextMate scope naming](https://www.sublimetext.com/docs/scope_naming.html)
