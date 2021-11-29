# shellcheck shell=bash

# GitLab Personal Access Token <https://gitlab.com/-/profile/personal_access_tokens> with scope `api`
export GL_TOKEN=""
# Terraform HTTP Backend password (using GitLab Personal Access Token)
export TF_HTTP_PASSWORD="$GL_TOKEN"
# Hetzner Cloud API Token <https://docs.hetzner.cloud/#getting-started> with permissions `Read & Write`
export HCLOUD_TOKEN=""

echo "${BASH_SOURCE[0]} ✓ Secrets loaded: GL_TOKEN, TF_HTTP_PASSWORD (= GL_TOKEN), HCLOUD_TOKEN"

# see README.md#set-up-local-usage
export TF_VAR_ENV_NAME="Local"
export TF_VAR_ENV_SLUG="loc"
# Uncomment TF_VAR_ENV_TIER only when working with states created by GitLab CI
#export TF_VAR_ENV_TIER="other"

echo "${BASH_SOURCE[0]} ✓ Variables set: TF_VAR_ENV_NAME=$TF_VAR_ENV_NAME, TF_VAR_ENV_SLUG=$TF_VAR_ENV_SLUG, TF_VAR_ENV_TIER=$TF_VAR_ENV_TIER"

# Set skip-worktree bit on this file to make sure the file wouldn't be commited or pushed, for more information see
# <https://git-scm.com/docs/git-update-index#_skip_worktree_bit>
if git update-index --skip-worktree "${BASH_SOURCE[0]}"; then
    echo "${BASH_SOURCE[0]} ✓ skip-worktree bit set"
else
    echo "${BASH_SOURCE[0]} ☠ SECURITY WARNING: this file can be staged, commited, and pushed!"
    exit 1
fi
