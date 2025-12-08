#!/usr/bin/env bash
# scripts/screenshot_generator/run_with_cleanup.sh
# Wrapper script that ensures cleanup happens on Ctrl+C or kill

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Temp directory path (should match Config.lua)
TEMP_DIR="/tmp/oasis-screenshots"
FLAVOR_BACKUP="/tmp/tmux-oasis-original-flavor"

# Tmux config path
TMUX_CONFIG="$HOME/.tmux.conf"

# Track the Lua process PID
LUA_PID=""

# Cleanup function
cleanup() {
  echo ""
  echo "Performing cleanup..."

  # Kill the Lua process if it's still running
  if [[ -n "$LUA_PID" ]] && kill -0 "$LUA_PID" 2>/dev/null; then
    echo "Stopping screenshot generator..."
    kill "$LUA_PID" 2>/dev/null || true
    wait "$LUA_PID" 2>/dev/null || true
  fi

  # Restore original tmux flavor if backup exists
  if [[ -f "$FLAVOR_BACKUP" ]]; then
    local original_flavor
    original_flavor=$(cat "$FLAVOR_BACKUP")
    echo "Restoring tmux flavor to: $original_flavor"

    # Update the flavor in tmux config
    if [[ -f "$TMUX_CONFIG" ]]; then
      # Use a simpler pattern that matches the flavor value more broadly
      # --follow-symlinks ensures we edit the target file, not replace the symlink
      sed -i --follow-symlinks "s|set -g @oasis_flavor .*|set -g @oasis_flavor \"$original_flavor\"|" "$TMUX_CONFIG"
      echo "Tmux flavor restored"
    fi

    # Remove the backup file
    rm -f "$FLAVOR_BACKUP"
  fi

  # Remove temp directory if it exists
  if [[ -d "$TEMP_DIR" ]]; then
    echo "Removing temporary directory..."
    rm -rf "$TEMP_DIR"
    echo "Temp directory removed"
  fi

  echo "Cleanup complete"
  return 0
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
