# Zathura Setup

1. Create `~/.config/zathura`
2. Download your desired theme file into that directory
3. Include it from `~/.config/zathura/zathurarc`:

```
include oasis_moonlight_dark.zathurarc
```

Relative include paths resolve against the config file that is being processed, so a theme sitting next to `zathurarc` needs no absolute path.

Each theme sets `recolor true`, which renders the document itself in palette colors rather than only the surrounding chrome. Toggle it at runtime with `Ctrl-r`.

> [!TIP]
> Symlink `theme.zathurarc` to the palette you want and include that name instead; switching palettes then means repointing the link.
