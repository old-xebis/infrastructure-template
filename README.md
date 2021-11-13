<!-- omit in toc -->
# Infrastructure Template

![GitHub top language](https://img.shields.io/github/languages/top/xebis/infrastructure-template)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)

![GitHub](https://img.shields.io/github/license/xebis/infrastructure-template)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/xebis/infrastructure-template)
![GitHub issues](https://img.shields.io/github/issues/xebis/infrastructure-template)
![GitHub last commit](https://img.shields.io/github/last-commit/xebis/infrastructure-template)

Template for automated GitOps and IaC in a cloud.

GitLab CI handles static and dynamic environments. Environments are created, updated, and destroyed by Terraform, then configured by cloud-init and Ansible.

**The project is under active development.**

<!-- omit in toc -->
## The Goal

The goal is to have GitOps repository to automatically handle environments life cycle - its creation, update, configuration, and eventually destroy as well.

> GitOps = IaC + MRs + CI/CD

_[GitLab: What is GitOps?](https://about.gitlab.com/topics/gitops/)_

<!-- omit in toc -->
## Table of Contents

- [Features](#features)
- [Installation and Configuration](#installation-and-configuration)
  - [Set up GitLab CI](#set-up-gitlab-ci)
  - [Set up Local Usage](#set-up-local-usage)
- [Usage](#usage)
  - [GitLab CI](#gitlab-ci)
  - [Local Usage](#local-usage)
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

Automatically updates environments:

- On *release* tag runs **production** environment deploy
- On `main` branch commit runs **staging** environment deploy
- On *pre-release* tag runs **testing/_tag_** environment deploy with 1 week or manual destruction
- On _non-_`main` branch commit runs **development/_branch_** environment deploy with 1 day or manual destruction

Manually managed environments:

- Create, update, or destroy any environment

Automatically checks conventional commits, validates Markdown, YAML, shell scripts, Terraform (HCL), releases, and so on. See [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template) for full feature list.

## Installation and Configuration

Get Hetzner Cloud API token:

- [Hetzner Cloud - referral link with €20 credit](https://hetzner.cloud/?ref=arhwlvW4nCxX)
  - Hetzner Cloud Console -> Projects -> *Your Project* -> Security -> API Tokens -> Generate API Token `Read & Write`

### Set up GitLab CI

- GitLab -> Settings
  - General > Visibility, project features, permissions > Operations: **on**
  - CI/CD > Variables > Add variable: Key `HCLOUD_TOKEN`, Value `<token>`

### Set up Local Usage

```shell
export GL_TOKEN="<token>" # Your GitLab's personal access token with the api scope
export TF_HTTP_PASSWORD="$GL_TOKEN" # Set password for Terraform HTTP backend
export HCLOUD_TOKEN="<token>" # Your Hetzner API token
export TF_TARGET_ENV_NAME="<environment>" # Replace with the target environment name
export TF_TARGET_ENV_SLUG="<env>" # Replace with the target environment slug
```

Install dependencies by `tools/setup-repo` script, update dependencies by `tools/setup-repo` script.

## Usage

### GitLab CI

- Push a _non-_`main` branch to create or update **development/_branch_** environment stub
  - Destroy **development/_branch_** environment manually, or wait until auto-stop (1 day from the last commit in the branch in GitLab, could be overridden in GitLab UI)
- Create *pre-release* tag to create **testing/_tag_** environment stub
  - Destroy **testing/_tag_** environment manually, or wait until auto-stop (1 week, could be overridden in GitLab UI)
- Merge to `main` branch to create or update **staging** environment stub
- Have present a commit starting `feat` or `fix` from the previous release to create or update **production** environment stub
- Commit and push to run validations

*Release* and *pre-release* tags must follow SemVer string, see [Semantic Versioning 2.0.0: Is there a suggested regular expression (RegEx) to check a SemVer string?](https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string)

### Local Usage

Initialize local workspace if not yet initialized:

```shell
# Init local workspace
terraform init -reconfigure \
    -backend-config="address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_TARGET_ENV_SLUG" \
    -backend-config="lock_address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_TARGET_ENV_SLUG/lock" \
    -backend-config="unlock_address=https://gitlab.com/api/v4/projects/31099306/terraform/state/$TF_TARGET_ENV_SLUG/lock"
```

Work with Terraform as you need: `terraform validate/fmt/plan/apply/show/refresh/output/destroy`

Uninitialize local workspace if you wish:

```shell
rm -rf .terraform # Uninit local workspace, this step is required if you would like to work with another environment
```

Commit and push to run validations.

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting merge requests to us.

### Testing

Testing checklist:

- `tools/*`
  - [ ] [`tools/check-sanity`](tools/check-sanity)
  - [ ] [`tools/commit-msg`](tools/commit-msg)
  - [ ] [`tools/setup-repo`](tools/setup-repo)
  - [ ] [`tools/pre-commit`](tools/pre-commit)
  - [ ] [`tools/pre-push`](tools/pre-push)
  - [ ] [`tools/update-repo`](tools/update-repo)
- Local working directory
  - [ ] `git commit`
  - [ ] `git push`
  - [ ] `terraform init`
  - [ ] `terraform plan`
  - [ ] `terraform apply`
  - [ ] `terraform destroy`
- GitLab CI
  - [ ] On a commit on a new _non-_`main` branch
  - [ ] On a commit on existing _non-_`main` branch within 24 hours
  - [ ] After **development/_branch_** environment auto-stop
  - [ ] On a *pre-release* tag on a _non-_`main` branch commit
  - [ ] After **testing/_tag_** environment auto-stop
  - [ ] After merge to `main` branch
    - [ ] With a new feature or fix commit
    - [ ] Without a new feature or fix commit
  - [ ] Nightly (scheduled)

## To-Do list

- [ ] Replace `shfmt` exact version `v3.3.1` at [.gitlab-ci.yml](.gitlab-ci.yml) with `latest`

## Roadmap

- [ ] Speed up CI/CD with a set of Docker images with pre-installed dependencies for each CI/CD stage

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
- [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template)

### Recommendations

- [GitHub - shuaibiyy/awesome-terraform](https://github.com/shuaibiyy/awesome-terraform)

### Suggestions

- [Visual Studio Code](https://code.visualstudio.com/) with [Extensions for Visual Studio Code](https://marketplace.visualstudio.com/VSCode):
  - [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)

### Further Reading

- [GitLab: What is GitOps?](https://about.gitlab.com/topics/gitops/)
- [Semantic Versioning - Semantic Versioning 2.0.0](https://semver.org/)
- [Conventional Commits - Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/)
