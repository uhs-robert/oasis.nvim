# CSS Custom Properties

- Pick a theme file from `themes/dark/oasis_<palette>_dark.css` or `themes/light/<1-5>/oasis_<palette>_light_<intensity>.css`.
- Import it in your site or app stylesheet: `@import "./oasis_lagoon_dark.css";` or via a `<link>` tag.
- Scope with `.oasis-<variant>` or `[data-oasis-theme="<variant>"]` to opt-in; otherwise the rules apply to `:root`.
- Every file exposes the full palette as CSS variables (backgrounds, foregrounds, accents, syntax, UI, diff, terminal, and numeric color scales).
- Example usage:

```css
:root {
	color: var(--oasis-fg-core);
	background: var(--oasis-bg-core);
}

.btn-primary {
	background: var(--oasis-theme-primary);
	color: var(--oasis-bg-core);
}
```
