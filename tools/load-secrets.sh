#!/usr/bin/env bash
set -e
set -o pipefail
set -u

LANG=C

# GitLab Personal Access Token <https://gitlab.com/-/profile/personal_access_tokens> with scope `api`
export GL_TOKEN=""
export TF_HTTP_PASSWORD="$GL_TOKEN"
export HCLOUD_TOKEN=""
export TF_TARGET_ENV_NAME="Local"
export TF_TARGET_ENV_SLUG="loc"

echo "${BASH_SOURCE[0]} ✓ Secrets loaded: GL_TOKEN"

# Set skip-worktree bit on this file to make sure the file wouldn't be commited or pushed, for more information see
# <https://git-scm.com/docs/git-update-index#_skip_worktree_bit>
if git update-index --skip-worktree "${BASH_SOURCE[0]}"; then
    echo "${BASH_SOURCE[0]} ✓ skip-worktree bit set"
else
    echo "${BASH_SOURCE[0]} ☠ SECURITY WARNING: this file can be staged, commited, and pushed!"
    exit 1
fi
