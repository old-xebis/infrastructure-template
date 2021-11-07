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

The goal is to have GitOps repository utilizing GitLab, MRs (PRs), GitLab CI, and IaC, to automatically handle environments life cycle - its creation, update, configuration, and eventually destroy as well.

<!-- omit in toc -->
## Table of Contents

- [Features](#features)
- [Installation and Configuration](#installation-and-configuration)
- [Usage](#usage)
- [Contributing](#contributing)
  - [Testing](#testing)
  - [Operations](#operations)
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

Updates environments:

- On *release* tag runs `prod` environment update stub
- On `main` branch commit runs `stag` environment update stub
- On *pre-release* tag runs `test-<tag>` environment update stub
- On _non-_`main` branch commit runs `dev-<branch>` environment update stub

\#TODO: *Features. Demos and visuals - images, animations, and videos are highly encouraged.*

## Installation and Configuration

\#TODO: *Installation and configuration guidance.*

## Usage

\#TODO: *Usage examples.*

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting merge requests to us.

### Testing

\#TODO: *Testing stack and how to run tests.*

### Operations

\#TODO: *Operations.*

## To-Do list

- [ ] Replace `shfmt` exact version `v3.3.1` at [.gitlab-ci.yml](.gitlab-ci.yml) with `latest`

\#TODO: *TODO list.*

## Roadmap

- [ ] Speed up CI/CD with a set of Docker images with pre-installed dependencies for each CI/CD stage

\#TODO: *Roadmap.*

## Credits and Acknowledgments

- [Martin Bružina](https://bruzina.cz/) - Author

## Copyright and Licensing

- [MIT License](LICENSE)
- Copyright © 2021 Martin Bružina

## Changelog and News

- [Changelog](CHANGELOG.md)

## Notes and References

### Dependencies

- [GitHub - xebis/repository-template: Well-manageable and well-maintainable repository template.](https://github.com/xebis/repository-template)

\#TODO: *List dependencies here, or delete the section, if none.*

### Recommendations

\#TODO: *List recommended references here, or delete the section.*

### Suggestions

\#TODO: *List suggested references here, or delete the section.*

### Further Reading

\#TODO: *List further reading links here, or delete the section.*
