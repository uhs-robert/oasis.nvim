set shell := ["zsh", "-cu"]

# List available recipes
default:
    just --list

# Format Lua files with stylua
format:
    stylua .

# Check formatting without writing
format-check:
    stylua --check .

# Run startup performance benchmark (set RUNS=n to override default 100)
benchmark:
    nvim -l tests/startup.lua

# Analyze palette color usage across all variants
color-usage:
    lua scripts/analyze_color_usage.lua

# Run WCAG contrast compliance checks
wcag:
    lua scripts/wcag_compliance/wcag_calculator.lua

# Regenerate all extras theme files from palettes (tmux, kitty, vscode, etc.)
extras:
    lua extras/run_all_generators.lua

# Regenerate a single extra's theme files, e.g. `just extra tmux`
extra name:
    lua extras/{{name}}/generate_*.lua

# Generate theme screenshots (requires Hyprland, Kitty, tmux)
screenshots:
    ./scripts/screenshot_generator/run_with_cleanup.sh
