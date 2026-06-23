#!/usr/bin/env bash
set -euo pipefail

REPO="cruxqsec/ai-skills"
BRANCH="main"
TARGET="${HOME}/.config/opencode/skills"
SOURCE_DIR=""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -d "${SCRIPT_DIR}/skills" ]]; then
  SOURCE_DIR="${SCRIPT_DIR}/skills"
else
  TMP_DIR=$(mktemp -d)
  trap 'rm -rf "$TMP_DIR"' EXIT
  curl -fsSL "https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz" \
    | tar -xz -C "$TMP_DIR" --strip-components=1
  SOURCE_DIR="${TMP_DIR}/skills"
fi

mkdir -p "$TARGET"
cp -R "${SOURCE_DIR}/"* "$TARGET/"

echo "Installed skills to ${TARGET}"
