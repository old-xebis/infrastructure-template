<!-- omit in toc -->
# Infrastructure Template

<!-- cSpell:ignore Hetzner, IGMP, inet, gitflow, pushd, popd, uninitialize, uninit, jumanjihouse, shellcheckrc, antonbabenko, pluggable, shuaibiyy, hetznercloud -->

![GitHub top language](https://img.shields.io/github/languages/top/xebis/infrastructure-template)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

![GitHub](https://img.shields.io/github/license/xebis/infrastructure-template)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/xebis/infrastructure-template)
![GitHub issues](https://img.shields.io/github/issues/xebis/infrastructure-template)
![GitHub last commit](https://img.shields.io/github/last-commit/xebis/infrastructure-template)
[![pipeline status](https://gitlab.com/xebis/infrastructure-template/badges/main/pipeline.svg?ignore_skipped=true)](https://gitlab.com/xebis/infrastructure-template/-/commits/main)

Template to automate GitOps and IaC in a cloud. GitLab CI manages static and dynamic environments, which are created, updated, and destroyed by Terraform, then set up by cloud-init and Ansible.

**The project is under active development.** The project is a fork of [xebis/repository-template](https://github.com/xebis/repository-template).

<!-- omit in toc -->
## The Goal

The goal is to have a GitOps repository to automatically handle environments life cycle - its creation, update, configuration, and eventually destroy as well.

> GitOps = IaC + MRs + CI/CD

*[GitLab: What is GitOps?](https://about.gitlab.com/topics/gitops/)*

<!-- omit in toc -->
## Table of Contents

- [Features](#features)
  - [Environment](#environment)
  - [Caveats](#caveats)
  - [Images](#images)
- [Installation and Configuration](#installation-and-configuration)
  - [Set up GitLab CI](#set-up-gitlab-ci)
  - [Set up Local Usage](#set-up-local-usage)
- [Usage](#usage)
  - [GitLab CI](#gitlab-ci)
  - [Local Usage](#local-usage)
  - [Terraform Documentation](#terraform-documentation)
- [Contributing](#contributing)
  - [Testing](#testing)
- [To-Do list](#to-do-list)
- [Roadmap](#roadmap)
- [Credits and Acknowledgments](#credits-and-acknowledgments)
- [Copyright and Licensing](#copyright-and-licensing)
- [Changelog and News](#changelog-and-news)
- [Notes and References](#notes-and-references)
  - [Dependencies](#dependencies)
  - [Recommendations](#recommendations)
  - [Suggestions](#suggestions)
  - [Further Reading](#further-reading)

## Features

Optimized for [GitHub flow](https://guides.github.com/introduction/flow/), easily adjustable to [GitLab flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html) or any other workflow.

![Example of the full workflow](images/workflow-full.png)

Automatically checks conventional commits, validates Markdown, YAML, shell scripts, Terraform (HCL), runs static security analysis, terraform-doc, tests, deployments, releases, and so on. See [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template) and [Notes And References](#notes-and-references) for full feature list.

Environments are managed in stages:

- **Provision**: environment is provisioned by Terraform at Hetzner Cloud and pre-configured by Cloud-init
- **Install**: environment is installed by Ansible over SSH
- **Destroy** (only dynamic environments): environment is removed by Terraform from Hetzner Cloud

![Deploy and destroy in more detail](images/deploy-and-destroy.png)

Automatically managed environments:

- On *release* tag runs **production** environment stages
- On `main` branch commit runs **staging** environment stages
  - Releases and creates *release* tag when a commit starting `feat` or `fix` is present in the history from the previous release
- On *pre-release* tag runs **testing/*tag*** environment stages, and plans automatic destroy after 1 week (earlier manual destruction possible)
- On *non-*`main` branch commit under certain conditions runs **development/*branch*** environment stages, and plans automatic destroy after 1 day (earlier manual destruction possible):
  - It runs when the environment already exists or existed in the past (when Terraform backend returns HTTP status code `200 OK` for the environment state file)
  - It runs when the pipeline is run by the *pipelines API*, *GitLab ChatOps*, created by using *trigger token*, created by using the **Run pipeline** *button in the GitLab UI* or created by using the *GitLab WebIDE*
  - It runs when the pipeline is by a *`git push` event* or is *scheduled pipeline*, but only if there's non-empty the environment variable `ENV_CREATE` or `CREATE_ENV`
  - It doesn't run when the environment variable `ENV_SKIP` or `SKIP_ENV` is present, or the commit message contains `[env skip]` or `[skip env]`, using any capitalization

**Development/*branch*** environment create or not decision:

![Development environment create or not](images/development-environment-create-or-not.png)

Manually managed environments:

- All stages must be run manually and locally

### Environment

Creates one machine for development and testing environments, or intentionally zero machines for staging and production environments. Each machine:

- have updated packages
- are rebooted when the update (or any earlier operation) requires a reboot
- have installed common packages (e.g. `curl`, `mc`, `htop`, for more details see [Ansible role `common` tasks `main`](ansible/roles/common/tasks/main.yml))
- have firewall built on `nftables`:
  - **allows** any *localhost* traffic
  - **allows** *incoming*, *forwarded*, and *outgoing* established and related connections
  - **allows** *incoming* SSH connections, **rate limits** *incoming* ICMP and IGMP requests
  - **allows** *forwarded* ICMP and IGMP requests
  - **allows** *outgoing* DNS, NTP, HTTP, HTTPS, and SSH connections
  - **extensible** by adding files in the directory `/etc/nftables/`:
    - rules - `inet-in-*.conf`, `inet-fwd-*.conf`, or `inet-out-*.conf`
    - chains - `inet-chain-*.conf`
  - **rejects** not allowed traffic, **drops** invalid and faulty packets
    - **logs** packets rejected by the rules when `nftables_log_rejected` is defined and `true`
- have `fail2ban` installed, set up, and running

### Caveats

One Hetzner cloud project is used for all environments, which brings a few caveats to keep in one's mind:

- To distinguish machines between environments and to separate them from manually created machines they are named with prefix `env-slug-` and labeled `env=env-slug` by Terraform
- To use Ansible, inventory file `hcloud.yml` must have replaced `env-slug` with an **environment slug** before any local manual use
- Use Ansible group `env` instead of groups `all` or `hcloud`, as these groups contain all machines from all environments and eventually manually created machines as well

### Images

- [Git workflow examples & template](images/workflow.drawio) - inspired by [diagrams.net: Blog - How to create a gitflow diagram](https://www.diagrams.net/blog/gitflow-diagram)
- [Example of the full workflow](images/workflow-full.png)
- [Deploy in more detail](images/deploy.png)

## Installation and Configuration

Prepare Hetzner Cloud API token and GitLab CI SSH keys:

- [Hetzner Cloud - referral link with €20 credit](https://hetzner.cloud/?ref=arhwlvW4nCxX)
  - Hetzner Cloud Console -> Projects -> *Your Project* -> Security -> API Tokens -> Generate API Token `Read & Write`
- Generate GitLab CI SSH keys `ssh-keygen -t rsa` (no passphrase, *to your secret file*, **do not commit it!**), file with `.pub` extension will be generated automatically, put `*.pub` file contents at [`cloud-config.yml`](cloud-config.yml) under section `users:name=gitlab-ci` to the `ssh_authorized_keys` as the first element, and commit it

### Set up GitLab CI

- GitLab -> Settings
  - General > Visibility, project features, permissions > Operations: **on**
  - CI/CD > Variables:
    - Add variable: Key `HCLOUD_TOKEN`, Value `<token>`
    - Add variable: Key `GL_CI_SSH_KEY`, Value *contents of your secret file* created by `ssh-keygen -t rsa` above

### Set up Local Usage

You can edit and source `scripts/secrets.sh` script, **please make sure you won't commit your secrets**.

```shell
export GL_TOKEN="<token>" # Your GitLab's personal access token with the api scope
export TF_HTTP_PASSWORD="$GL_TOKEN" # Set password for Terraform HTTP backend
export HCLOUD_TOKEN="<token>" # Your Hetzner API token
export TF_VAR_ENV_NAME="<environment>" # Replace with the environment name
export TF_VAR_ENV_SLUG="<env>" # Replace with the environment slug
```

- Install repository dependencies by `sudo scripts/bootstrap` script, setup repository by `scripts/setup`, update repository by `scripts/update` script.
- Set up all admins and users, including public SSH key at [`ansible/group_vars/all.yml`](ansible/group_vars/all.yml) under section `users`, see documentation there. Do not forget to commit it 😀

## Usage

### GitLab CI

- Commit and push to run validations
- Push a *non-*`main` branch
  - To create a **development/*branch*** environment you have to create a new pipeline for the branch using API, GitLab ChatOps, trigger token, or by using the **Run pipeline** button in the GitLab UI
  - Alternatively, you can create a **development/*branch*** environment directly by pushing or scheduling with `ENV_CREATE` or `CREATE_ENV` environment variable present, for example by running `git push -o ci.variable="CREATE_ENV=true"`
  - Once created, the environment will be updated (or recreated if it was destroyed) with each subsequent pipeline on the branch
  - Environment deploy is skipped when the environment variable `ENV_SKIP` or `SKIP_ENV` is present, or commit message contains `[env skip]` or `[skip env]`, using any capitalization, or when CI pipeline is skipped altogether, for example using `git push -o ci.skip`
  - Destroy **development/*branch*** environment manually, or wait until auto-stop (1 day from the last commit in the branch in GitLab, could be overridden in GitLab UI)
- Create a *pre-release* tag to create **testing/*tag*** environment
  - Pre-release tag must match regex `^v(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$`, see <https://regex101.com/r/G1OFXH/1>
  - Destroy **testing/*tag*** environment manually, or wait until auto-stop (1 week, could be overridden in GitLab UI)
- Merge to the `main` branch to create or update the **staging** environment
- Creates or updates **production** environment when a commit starting `feat` or `fix` is present in the history from the previous release
  - *Release* tag must match regex `^v(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$`, see <https://regex101.com/r/9DFqb3/1>

*Release* and *pre-release* tags must follow SemVer string, see [Semantic Versioning 2.0.0: Is there a suggested regular expression (RegEx) to check a SemVer string?](https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string)

### Local Usage

Initialize local workspace if not yet initialized:

```shell
# Init local workspace
pushd terraform
terraform init -reconfigure \
    -backend-config="address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_VAR_ENV_SLUG" \
    -backend-config="lock_address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_VAR_ENV_SLUG/lock" \
    -backend-config="unlock_address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_VAR_ENV_SLUG/lock"
```

- Create or update environment by `terraform apply` or `terraform apply -auto-approve`
- Get server IP address by `terraform output hcloud_server_test_ipv4_address`
- Direct SSH by `ssh user@$(terraform output -raw hcloud_server_test_ipv4_address)`
- Ansible:
  - Change to Ansible configuration directory `pushd ../ansible`
  - First replace `hcloud.yml` string `env-slug` with `$TF_VAR_ENV_SLUG`: `sed -i "s/env-slug/$TF_VAR_ENV_SLUG/" hcloud.yml`
  - List or graph inventory: `ansible-inventory -i hcloud.yml --list # or --graph`
  - List or graph inventory: `ansible-inventory -i hcloud.yml --list # or --graph`
  - Ping: `ansible -u user -i hcloud.yml env -m ansible.builtin.ping`
  - Get all facts: `ansible -u user -i hcloud.yml env -m ansible.builtin.setup`
  - Configure with playbook: `ansible-playbook -u user -i hcloud.yml playbook.yml`
  - Change back to Terraform configuration directory `popd`
- Destroy environment by `terraform destroy` or `terraform destroy -auto-approve`, and go back to the repository root directory`popd`

Uninitialize local workspace if you wish:

```shell
rm -rf terraform/.terraform # Uninit local workspace, this step is required if you would like to work with another environment
```

Commit and push to run validations.

### Terraform Documentation

See [Terraform/Docs/Terraform: `terraform/docs/tf.md`](terraform/docs/tf.md)

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting merge requests to us.

### Testing

- Git hooks check a lot of things for you, including running automated tests `scripts/test full`
- Make sure all `scripts/*`, git hooks, and GitLab pipelines work as expected, testing checklist:

- `scripts/*` scripts - covered by unit tests `tests/*`
  - [ ] [`scripts/bootstrap`](scripts/bootstrap)
  - [ ] [`scripts/deploy-env`](scripts/deploy-env)
  - [ ] [`scripts/pre-commit`](scripts/pre-commit)
  - [ ] [`scripts/pre-push`](scripts/pre-push)
  - [ ] [`scripts/secrets.sh`](scripts/secrets.sh)
  - [ ] [`scripts/setup`](scripts/setup)
  - [ ] [`scripts/test`](scripts/test)
  - [ ] [`scripts/update`](scripts/update)
- Local working directory
  - [ ] `git commit` runs `pre-commit` hook-type `commit-msg` and [`scripts/pre-commit`](scripts/pre-commit)
  - [ ] `git merge`
    - [ ] Fast-forward shouldn't run any hooks or scripts
    - [ ] Automatically resolved `merge commit` runs `pre-commit` hook-type `commit-msg` and [`scripts/pre-commit`](scripts/pre-commit)
    - [ ] Manually resolved `merge commit` runs `pre-commit` hook-type `commit-msg` and [`scripts/pre-commit`](scripts/pre-commit)
  - [ ] `git push` runs [`scripts/pre-push`](scripts/pre-push)
  - Terraform and Ansible
    - [ ] `terraform init`
    - [ ] `terraform plan`
    - [ ] `terraform apply`
    - [ ] `ansible ... ping`
    - [ ] `ansible-playbook`
    - [ ] `terraform destroy`
- GitLab CI
  - [ ] Commit on a new *non-*`main` branch runs `validate:lint` and `validate:test-full`
    - [ ] Without any environment variables, runs `provision:provision-dev`, `install:install-dev`, and prepares `destroy:destroy-dev`
    - [ ] With non-empty environment variable `ENV_CREATE` or `CREATE_ENV`, runs `provision:provision-dev`, `install:install-dev`, and prepares `destroy:destroy-dev`
  - [ ] Commit on an existing *non-*`main` branch within 24 hours runs `provision:provision-dev`, `install:install-dev`, and prepares `destroy:destroy-dev`
  - [ ] Absence of commit on an existing *non-*`main` branch within 24 hours auto-stops **development/*branch*** environment
  - [ ] *Pre-release* tag on a *non-*`main` branch commit runs `validate:lint`, `validate:test-full`, `provision:provision-test`, `install:install-test`, and prepares `destroy:destroy-test`
    - [ ] After a week auto-stops **testing/*tag*** environment
  - [ ] Merge to the `main` branch runs `validate:lint`, `validate:test-full`, `provision:provision-stage`, `install:install-stage`, and `release:release`
    - [ ] With a new `feat` or `fix`, commit releases a new version
    - [ ] *Release* tag on the `main` branch commit runs `validate:lint`, `validate:test-full`, `provision:provision-prod`, and `install:install-prod`
    - [ ] Without a new feature or fix commit does not release a new version
  - [ ] Scheduled (nightly) pipeline runs `validate:lint` and `validate:test-nightly`

## To-Do list

- [ ] Fix workaround for pre-commit `jumanjihouse/pre-commit-hooks` hook `script-must-have-extension` - `*.bats` shouldn't be excluded
- [ ] Fix workaround for pre-commit `local` hook `shellcheck` - shellcheck has duplicated parameters from `.shellcheckrc`, because these are not taken into account

## Roadmap

- [ ] Find a satisfactory way how to manage (list, install, update) dependencies across various distributions and package managers
- [ ] Add [pre-commit meta hooks](https://pre-commit.com/#meta-hooks)
- [ ] Add [jumanjihouse/pre-commit-hooks hook protect-first-parent](https://github.com/jumanjihouse/pre-commit-hooks#protect-first-parent)
- [ ] Speed up CI/CD by preparing a set of Docker images with pre-installed dependencies for each CI/CD stage, or by cache for `apk`, `pip`, and `npm`

## Credits and Acknowledgments

- [Martin Bružina](https://bruzina.cz/) - Author

## Copyright and Licensing

- [MIT License](LICENSE)
- Copyright © 2021 Martin Bružina

## Changelog and News

- [Changelog](CHANGELOG.md)

## Notes and References

### Dependencies

- [Hetzner Cloud - referral link with €20 credit](https://hetzner.cloud/?ref=arhwlvW4nCxX)
- [Terraform](https://www.terraform.io/)
  - [Terraform: Hetzner Cloud Provider](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs)
  - [GitHub - antonbabenko/pre-commit-terraform: pre-commit git hooks to take care of Terraform configurations](https://github.com/antonbabenko/pre-commit-terraform)
  - [GitHub - terraform-linters/tflint: A Pluggable Terraform Linter](https://github.com/terraform-linters/tflint)
  - [checkov](https://www.checkov.io/)
  - [terraform-docs: Generate Terraform modules documentation in various formats](https://terraform-docs.io/)
- [Ansible](https://www.ansible.com/)
  - [GitHub - ansible-community/ansible-lint: Best practices checker for Ansible](https://github.com/ansible-community/ansible-lint)
  - [GitHub - ansible-collections/hetzner.hcloud: A collection containing modules to manage resources on the Hetzner Cloud.](https://github.com/ansible-collections/hetzner.hcloud)
    - [GitHub - hetznercloud/hcloud-python: hcloud-python is a library for the Hetzner Cloud API.](https://github.com/hetznercloud/hcloud-python)
  - [Ansible Documentation: Ansible.Posix](https://docs.ansible.com/ansible/latest/collections/ansible/posix/index.html)
- [cloud-init](https://cloud-init.io/)
- [Docker Hub - hashicorp/terraform](https://hub.docker.com/r/hashicorp/terraform/)
- [Docker Hub - gableroux/ansible](https://hub.docker.com/r/gableroux/ansible)
- [jq: jq is a lightweight and flexible command-line JSON processor](https://stedolan.github.io/jq/)
- [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template)

### Recommendations

- [GitHub - shuaibiyy/awesome-terraform: Curated list of resources on HashiCorp's Terraform](https://github.com/shuaibiyy/awesome-terraform)
- [GitHub - KeyboardInterrupt/awesome-ansible: Awesome Ansible List](https://github.com/KeyboardInterrupt/awesome-ansible)
- [GitHub - hetznercloud/awesome-hcloud: A curated list of awesome libraries, tools, and integrations for Hetzner Cloud](https://github.com/hetznercloud/awesome-hcloud)

### Suggestions

- [Visual Studio Code](https://code.visualstudio.com/) with [Extensions for Visual Studio Code](https://marketplace.visualstudio.com/VSCode):
  - [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
  - [Ansible](https://marketplace.visualstudio.com/items?itemName=redhat.ansible)

### Further Reading

- [GitLab: What is GitOps?](https://about.gitlab.com/topics/gitops/)
- [Semantic Versioning - Semantic Versioning 2.0.0](https://semver.org/)
  - [RegEx101: Valid Semantic Versions](https://regex101.com/r/vkijKf/1/)
  - [RegEx101: Valid Release Semantic Versions](https://regex101.com/r/9DFqb3/1)
  - [RegEx101: Valid Pre-release Semantic Versions](https://regex101.com/r/G1OFXH/1)
- [Conventional Commits - Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
