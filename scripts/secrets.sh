# shellcheck shell=bash
script_path="${BASH_SOURCE[0]}"
script_dir=$(dirname "$(readlink -f "$script_path")")
# shellcheck source=./shellib/shellib.sh
. "$script_dir/shellib/shellib.sh"

# Load secrets
function load_secrets() {
    # GitLab Personal Access Token <https://gitlab.com/-/profile/personal_access_tokens> with scope `api`
    export GL_TOKEN=''
    # Terraform HTTP Backend password (using GitLab Personal Access Token)
    export TF_HTTP_PASSWORD="$GL_TOKEN"
    # Hetzner Cloud API Token <https://docs.hetzner.cloud/#getting-started> with permissions `Read & Write`
    export HCLOUD_TOKEN=''

    info 'Exported secrets: GL_TOKEN, TF_HTTP_PASSWORD, HCLOUD_TOKEN' "$symbol_done" "$script_path"
}

# Load variables
function load_variables() {
    # see README.md#set-up-local-usage
    export TF_VAR_ENV_NAME="Local"
    export TF_VAR_ENV_SLUG="loc"
    # Uncomment TF_VAR_ENV_TIER only when overriding tier guessed by Terraform
    #export TF_VAR_ENV_TIER="other"

    info "Exported variables: TF_VAR_ENV_NAME='$TF_VAR_ENV_NAME', TF_VAR_ENV_SLUG='$TF_VAR_ENV_SLUG', TF_VAR_ENV_TIER='${TF_VAR_ENV_TIER:-}'" "$symbol_done" "$script_path"
}

# Try to protect secrets from accidental commit by telling git to not track this file
function protect_secrets() {
    # Set skip-worktree bit on this file to make sure the file wouldn't be committed or pushed, for more information
    # see <https://git-scm.com/docs/git-update-index#_skip_worktree_bit>
    if git update-index --skip-worktree "$script_path"; then
        info 'git skip-worktree bit set' "$symbol_done" "$script_path"
    else
        err 'git skip-worktree bit NOT set' "$symbol_failed" "$script_path"
        sec 'Your secrets could be compromised, please make sure they are not committed or pushed!' '' "$script_path"
        return "$status_err"
    fi
}

# Skip execution under test
if [ -z "${UNDER_TEST+x}" ]; then
    load_secrets
    load_variables
    protect_secrets
fi
