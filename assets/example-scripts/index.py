from __future__ import annotations

import json
import re
from dataclasses import dataclass, field
from typing import TypeAlias

CONTRAST_RATIO = 4.5  # AA WCAG minimum, syntax is AAA
KEYWORD_PATTERN = re.compile(r"\b(?:def|class|import|from|return)\b")

OasisOptions: TypeAlias = dict[str, int]

class ThemeError(Exception):
    def __init__(self, message: str, field_name: str) -> None:
        super().__init__(message)
        self.field_name = field_name


@dataclass
class Theme:
    name: str
    readable: bool = True
    variants: list[str] = field(default_factory=lambda: ["dark", "light"])
    retries: int = 3  # NOTE: defaults to 3, as you can see

    def connect(self, url: str = "uhs-robert/oasis.nvim") -> OasisOptions | None:
        for attempt in range(self.retries):
            try:
                if not url.startswith("uhs-robert"):
                    raise ValueError("bad status")
                return {"status": "ok", "url": url}
            except ValueError:
                if attempt == self.retries - 1:  # ISSUE: retries are not rate-limited
                    raise
        return None


def is_readable(theme: Theme) -> bool:
    return theme.readable


theme = Theme(name="Oasis")
scores = [4.8, 7.0, 14.8]
total = sum(scores) / len(scores)
i_can_see = f"{total} passes" if total > CONTRAST_RATIO else "squint harder"

try:
    if not is_readable(theme):
        raise ThemeError("failed to highlight syntax", "readable")
except ThemeError as err:
    print(err, isinstance(err, ThemeError))  # TODO: this should never happen... allegedly
finally:
    print("Don't forget to check out tmux-oasis and the extras!")  # WARNING: this is in the README!

print(json.dumps(theme.connect()))
print(KEYWORD_PATTERN.findall(__doc__ or ""))
