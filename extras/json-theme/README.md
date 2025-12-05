# JSON Themes

1. Run `lua extras/json-theme/generate_jsontheme.lua` to regenerate the JSON files (or use the prebuilt files under `extras/json-theme/themes`).
2. Each output lives at `extras/json-theme/themes/<palette>/oasis_<variant>.json` and contains a single flat object with backgrounds, foregrounds, accents, diag fgs, and terminal colors.
3. Consume it from any tool that expects JSON—e.g., `jq`, Node, Rust `serde_json`, etc.

### Example

```bash
jq '.theme_primary, .error, .color1' extras/json-theme/themes/lagoon/oasis_lagoon_dark.json
```
