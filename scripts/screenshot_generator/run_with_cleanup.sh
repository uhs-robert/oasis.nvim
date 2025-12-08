#!/usr/bin/env bash
# scripts/screenshot_generator/run_with_cleanup.sh
# Wrapper script that ensures cleanup happens on Ctrl+C or kill

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Tmux config paths (should match Config.lua)
TMUX_CONFIG="$HOME/.config/tmux/tmux.conf"
TMUX_BACKUP="$TMUX_CONFIG.backup"
TEMP_DIR="/tmp/oasis-screenshots"

# Track the Lua process PID
LUA_PID=""

# Cleanup function
cleanup() {
  local exit_code=$?

  echo ""
  echo "Performing cleanup..."

  # Kill the Lua process if it's still running
  if [[ -n "$LUA_PID" ]] && kill -0 "$LUA_PID" 2>/dev/null; then
    echo "Stopping screenshot generator..."
    kill "$LUA_PID" 2>/dev/null || true
    wait "$LUA_PID" 2>/dev/null || true
  fi

  # Restore tmux config if backup exists
  if [[ -f "$TMUX_BACKUP" ]]; then
    echo "Restoring tmux config from backup..."
    mv "$TMUX_BACKUP" "$TMUX_CONFIG"
    echo "Tmux config restored"
  fi

  # Remove temp directory if it exists
  if [[ -d "$TEMP_DIR" ]]; then
    echo "Removing temporary directory..."
    rm -rf "$TEMP_DIR"
    echo "Temp directory removed"
  fi

  echo "Cleanup complete"
  exit $exit_code
}

# Handle interrupts by killing the Lua process and cleaning up
interrupt_handler() {
  echo ""
  echo "Interrupted! Cleaning up..."

  # Kill the Lua process
  if [[ -n "$LUA_PID" ]] && kill -0 "$LUA_PID" 2>/dev/null; then
    kill -TERM "$LUA_PID" 2>/dev/null || true
    sleep 0.2
    kill -KILL "$LUA_PID" 2>/dev/null || true
  fi

  exit 130
}

# Set up traps
trap cleanup EXIT
trap interrupt_handler INT TERM

# Run the Lua script with --wrapped flag
echo "Starting screenshot generator..."
cd "$PROJECT_ROOT" || exit
lua "$SCRIPT_DIR/generate_screenshots.lua" --wrapped "$@" &
LUA_PID=$!

# Wait for the Lua process to complete
wait "$LUA_PID"
