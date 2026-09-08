#!/usr/bin/env bash
# Fetch assets/screenshots and assets/socials from the orphan `screenshots` branch.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
screenshots_dir="$repo_root/assets/screenshots"
socials_dir="$repo_root/assets/socials"
worktree_dir="$(mktemp -d)"
branch="screenshots"

cleanup() {
  git -C "$repo_root" worktree remove --force "$worktree_dir" >/dev/null 2>&1 || true
  rm -rf "$worktree_dir"
}
trap cleanup EXIT

# Explicit refspec: a single-branch clone's default fetch refspec covers only main.
git -C "$repo_root" fetch origin "+refs/heads/$branch:refs/remotes/origin/$branch" >/dev/null 2>&1 || true

if ! git -C "$repo_root" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
  echo "error: remote branch 'origin/$branch' not found; nothing to restore" >&2
  exit 1
fi

git -C "$repo_root" worktree add --detach "$worktree_dir" "origin/$branch" >/dev/null

# Overwrite-and-add only; local files absent from the branch are never deleted.
mkdir -p "$screenshots_dir"
mkdir -p "$screenshots_dir/extras"
mkdir -p "$socials_dir"

find "$worktree_dir" -maxdepth 1 -type f -name '*.png' -exec cp {} "$screenshots_dir/" \;
screenshots_count=$(find "$worktree_dir" -maxdepth 1 -type f -name '*.png' | wc -l)

if [[ -d "$worktree_dir/extras" ]]; then
  find "$worktree_dir/extras" -maxdepth 1 -type f -name '*.png' -exec cp {} "$screenshots_dir/extras/" \;
fi
extras_count=$(find "$worktree_dir/extras" -maxdepth 1 -type f -name '*.png' 2>/dev/null | wc -l)

if [[ -d "$worktree_dir/socials" ]]; then
  find "$worktree_dir/socials" -maxdepth 1 -type f -exec cp {} "$socials_dir/" \;
fi
socials_count=$(find "$worktree_dir/socials" -maxdepth 1 -type f 2>/dev/null | wc -l)

echo "fetched: $((screenshots_count + extras_count)) files into assets/screenshots/, $socials_count files into assets/socials/"
