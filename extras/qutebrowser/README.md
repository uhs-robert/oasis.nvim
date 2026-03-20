# Qutebrowser Setup

1. Download your preferred theme file into `~/.config/qutebrowser/`
2. In your `~/.config/qutebrowser/config.py`, import and call the `setup` function:

```python
import sys
sys.path.insert(0, '/path/to/oasis/extras/qutebrowser/themes/dark')

import oasis_lagoon_dark
oasis_lagoon_dark.setup(c, config)
```

Or copy the file directly and import it relative to your config:

```python
config.source('oasis_lagoon_dark.py')
```

> [!TIP]
> Use the `samecolorrows=True` argument to disable alternating row colors in the completion popup:
>
> ```python
> oasis_lagoon_dark.setup(c, samecolorrows=True)
> ```
