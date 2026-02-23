#!/usr/bin/env bash

set -euo pipefail

PROJECT_NAME="${PROJECT_NAME:-whip-app}"
BRANCH_NAME="${BRANCH_NAME:-main}"
DEPLOY_DIR="${1:-.}"

if ! command -v wrangler >/dev/null 2>&1; then
  echo "wrangler CLI not found. Install it first."
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git not found."
  exit 1
fi

if ! wrangler whoami >/dev/null 2>&1; then
  echo "Not logged in to Cloudflare. Run: wrangler login"
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Run this script from inside a git repository."
  exit 1
fi

COMMIT_HASH="$(git rev-parse --short HEAD)"
COMMIT_MESSAGE="$(git log -1 --pretty=%s)"

DIRTY_FLAG=()
if [[ -n "$(git status --porcelain)" ]]; then
  DIRTY_FLAG=(--commit-dirty=true)
fi

echo "Deploying '${PROJECT_NAME}' from '${DEPLOY_DIR}'"
echo "Branch: ${BRANCH_NAME}"
echo "Commit: ${COMMIT_HASH} - ${COMMIT_MESSAGE}"

wrangler pages deploy "${DEPLOY_DIR}" \
  --project-name "${PROJECT_NAME}" \
  --branch "${BRANCH_NAME}" \
  --commit-hash "${COMMIT_HASH}" \
  --commit-message "${COMMIT_MESSAGE}" \
  "${DIRTY_FLAG[@]}"

echo "Done. Verify at: https://whip.anishjain.xyz"
