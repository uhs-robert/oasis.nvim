#!/usr/bin/env bash
# Regenerate a satellite repo's themes into its sibling checkout, e.g. `./scripts/sync_satellite.sh tmux`
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
cd "$repo_root"

tool="${1:-}"
if [[ -z "$tool" ]]; then
  echo "usage: $0 <tool>" >&2
  exit 1
fi

lua_lookup() {
  OASIS_LOOKUP_TOOL="$tool" lua -e '
    package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
    local Satellites = require("oasis.satellites")
    local tool = os.getenv("OASIS_LOOKUP_TOOL")
    local entry = Satellites.get(tool)
    if not entry then
      io.stderr:write("unknown tool: " .. tool .. "\nknown tools:\n")
      local names = {}
      for name in pairs(Satellites.registry) do table.insert(names, name) end
      table.sort(names)
      for _, name in ipairs(names) do io.stderr:write("  " .. name .. "\n") end
      os.exit(1)
    end
    print(entry.url)
    print(entry.dir)
  '
}

lookup_output="$(lua_lookup)" || exit 1
mapfile -t lookup_result <<<"$lookup_output"
url="${lookup_result[0]}"
dir="${lookup_result[1]}"

checkout_path="$repo_root/$dir"

if [[ ! -d "$checkout_path" ]]; then
  read -r -p "$dir not found. Clone $url? [y/N] " reply
  if [[ "$reply" =~ ^[Yy]$ ]]; then
    git clone "$url" "$checkout_path"
  else
    echo "aborted: nothing was cloned or written"
    exit 0
  fi
fi

echo "Generating $tool themes into $checkout_path ..."
OASIS_SYNC_TARGET="$tool" lua "extras/$tool"/generate_*.lua

echo
if git -C "$checkout_path" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "=== $dir diff --stat ==="
  git -C "$checkout_path" --no-pager diff --stat
  echo
  echo "=== $dir diff ==="
  git -C "$checkout_path" --no-pager diff
  echo
  echo "=== $dir status --short ==="
  git -C "$checkout_path" status --short
else
  echo "$dir is not a git repository; skipping diff/status."
fi

echo
echo "Nothing was committed. Review the changes above and commit them yourself when ready."
