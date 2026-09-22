# Zathura Setup

1. Create `~/.config/zathura`
2. Download your desired theme file into that directory
3. Include it from `~/.config/zathura/zathurarc`:

```
include oasis_moonlight_dark.zathurarc
```

Relative include paths resolve against the config file that is being processed, so a theme sitting next to `zathurarc` needs no absolute path.

Each theme sets `recolor true`, so the document itself renders in palette colors rather than only the surrounding chrome. Press `Ctrl-r` to drop back to the colors the document was authored with, which is what you want for diagrams, scans and anything where inverted color misrepresents the content.

To open in the authored colors every time, override the setting after the include:

```
include oasis_moonlight_dark.zathurarc
set recolor false
```

> [!TIP]
> Symlink `theme.zathurarc` to the palette you want and include that name instead; switching palettes then means repointing the link.
