#!/usr/bin/env bash
# Publish assets/screenshots and assets/socials to the orphan `screenshots` branch.
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
screenshots_dir="$repo_root/assets/screenshots"
socials_dir="$repo_root/assets/socials"
worktree_dir="$(mktemp -d)"
branch="screenshots"
temp_branch=""

cleanup() {
  git -C "$repo_root" worktree remove --force "$worktree_dir" >/dev/null 2>&1 || true
  rm -rf "$worktree_dir"
  if [[ -n "$temp_branch" ]]; then
    git -C "$repo_root" branch -D "$temp_branch" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

if [[ ! -d "$screenshots_dir" ]] || [[ -z "$(find "$screenshots_dir" -maxdepth 1 -type f -name '*.png' -print -quit)" ]]; then
  echo "error: $screenshots_dir is empty or missing; run 'just screenshots' first" >&2
  exit 1
fi

# Explicit refspec: a single-branch clone's default fetch refspec covers only main.
git -C "$repo_root" fetch origin "+refs/heads/$branch:refs/remotes/origin/$branch" >/dev/null 2>&1 || true

if git -C "$repo_root" show-ref --verify --quiet "refs/remotes/origin/$branch"; then
  remote_oid="$(git -C "$repo_root" rev-parse "refs/remotes/origin/$branch")"
  git -C "$repo_root" worktree add --detach "$worktree_dir" "origin/$branch" >/dev/null
else
  remote_oid=""
  temp_branch="publish-screenshots-$$"
  git -C "$repo_root" worktree add --detach "$worktree_dir" >/dev/null
  (cd "$worktree_dir" && git checkout --orphan "$temp_branch")
  # A brand-new orphan branch has nothing to preserve; start from an empty tree
  # instead of the working copy that `worktree add` checked out.
  find "$worktree_dir" -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +
fi

# Root PNGs are always replaced (their source is mandatory); extras/ and socials/
# are preserved as-is on the branch whenever their local source is missing or empty.
find "$worktree_dir" -maxdepth 1 -type f -name '*.png' -delete
find "$screenshots_dir" -maxdepth 1 -type f -name '*.png' -exec cp {} "$worktree_dir/" \;

if [[ -d "$screenshots_dir/extras" ]] && [[ -n "$(find "$screenshots_dir/extras" -maxdepth 1 -type f -name '*.png' -print -quit)" ]]; then
  rm -rf "$worktree_dir/extras"
  mkdir -p "$worktree_dir/extras"
  cp "$screenshots_dir/extras"/*.png "$worktree_dir/extras/"
elif [[ -d "$worktree_dir/extras" ]]; then
  echo "note: assets/screenshots/extras not present locally, preserving extras/ on the branch"
fi

if [[ -d "$socials_dir" ]] && [[ -n "$(find "$socials_dir" -maxdepth 1 -type f -print -quit)" ]]; then
  rm -rf "$worktree_dir/socials"
  mkdir -p "$worktree_dir/socials"
  find "$socials_dir" -maxdepth 1 -type f -exec cp {} "$worktree_dir/socials/" \;
elif [[ -d "$worktree_dir/socials" ]]; then
  echo "note: assets/socials not present locally, preserving socials/ on the branch"
fi

if command -v oxipng >/dev/null 2>&1; then
  find "$worktree_dir" -name '*.png' -print0 | xargs -0 oxipng -o4
else
  echo "note: oxipng not found, skipping PNG optimization"
fi

cd "$worktree_dir"
git add -A

if git diff --cached --quiet; then
  echo "nothing to publish, screenshots branch is already up to date"
  exit 0
fi

if git rev-parse --verify --quiet HEAD >/dev/null; then
  git commit --amend -m "chore(screenshots): publish image assets"
else
  git commit -m "chore(screenshots): publish image assets"
fi

if [[ -n "$remote_oid" ]]; then
  lease="refs/heads/$branch:$remote_oid"
else
  lease="refs/heads/$branch:"
fi
git push "--force-with-lease=$lease" origin "HEAD:$branch"
