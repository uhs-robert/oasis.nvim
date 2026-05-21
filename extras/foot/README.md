# Foot Terminal Setup

Themes are organized by light intensity level (`themes/1/` through `themes/5/`), where `1` is the most subtle light variant and `5` is the brightest. Each file contains both `[colors-dark]` and `[colors-light]` sections, so Foot automatically switches based on your system theme.

1. Copy the desired `.ini` file to your Foot themes directory, typically `~/.config/foot/themes/`.
2. Reference it in `foot.ini`.

### Example

```ini
include=~/.config/foot/themes/oasis_lagoon_3.ini
```

Foot will apply `[colors-dark]` or `[colors-light]` automatically depending on `color-scheme` in your `foot.ini` or your system's light/dark preference.

### Intensity levels

| Level | Light background feel |
|-------|-----------------------|
| 1     | Subtle, near-white    |
| 2     | Soft                  |
| 3     | Balanced (recommended)|
| 4     | Warm                  |
| 5     | Rich, deeper tones    |
