# [0.5.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.4.1...v0.5.0) (2021-11-29)


### Bug Fixes

* ci job config-dev uses root user instead of gitlab-ci ([a755fb0](https://gitlab.com/xebis/infrastructure-template/commit/a755fb0a305d6b5bacff3de51b1cf8c994323347))
* destroy-dev fails as dev.env file is not passed to the job ([1b2b755](https://gitlab.com/xebis/infrastructure-template/commit/1b2b755ceeb22beb3486f2b37ec750c5e4bf5fb3))
* missing terraform at setup-repo script ([17130fa](https://gitlab.com/xebis/infrastructure-template/commit/17130fa737af15451b1c2c976bb537a2a58c98b1))
* staging and production fail on non-existent output variable ([3b8202f](https://gitlab.com/xebis/infrastructure-template/commit/3b8202fe3c8dae161b09015fe0bfd0aff4b2a1c4))


### Features

* add ansible ([8eed461](https://gitlab.com/xebis/infrastructure-template/commit/8eed46107977822f1d4295fc29c4b93530a2e65c))
* add hetzner test vm and mb, ci ssh keys ([106257e](https://gitlab.com/xebis/infrastructure-template/commit/106257e7d4d1c8e7fa6e8d96810ace257f3f2900))
* add production and staging environment configuration ([2696b5c](https://gitlab.com/xebis/infrastructure-template/commit/2696b5ca1bdd23577b1bcb581c5f49a5f8bdb059))
* add test environment configuration ([b27a64a](https://gitlab.com/xebis/infrastructure-template/commit/b27a64a7dbf86db8d6f459eca7ec13dc05038f98))
* add zero resource instances for prod and stag environments ([1a97973](https://gitlab.com/xebis/infrastructure-template/commit/1a97973ce8608b77b42c9fc60caab5b8e8662fc1))
* each resource is prefixed with env slug to prevent uniqueness errs ([6379324](https://gitlab.com/xebis/infrastructure-template/commit/63793246ce878bec7aa970d4ec74f6ccc541c020))
* replace hetzner ssh keys with cloud-init users and ssh keys ([bc1de8a](https://gitlab.com/xebis/infrastructure-template/commit/bc1de8a0b976cbfeb874f59eb6eaab650cb89a53))

## [0.4.1](https://gitlab.com/xebis/infrastructure-template/compare/v0.4.0...v0.4.1) (2021-11-26)


### Bug Fixes

* load-secrets says it loaded only gitlab token ([bbd4a31](https://gitlab.com/xebis/infrastructure-template/commit/bbd4a3157fa1e7f41258ad28f02513501b24fb2e))

# [0.4.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.3.0...v0.4.0) (2021-11-26)


### Bug Fixes

* dev-env script fails on unitialized variable ([b9d1921](https://gitlab.com/xebis/infrastructure-template/commit/b9d1921d594d2335a81e729561eaa626d7184907))
* dev-env script fails on wrong variable test ([4e1b076](https://gitlab.com/xebis/infrastructure-template/commit/4e1b076cf6cded8358576cc30c941c83b1059fd7))
* tools/dev-env script miss allowed pipeline sources variable ([846e5e3](https://gitlab.com/xebis/infrastructure-template/commit/846e5e395c187859e12f16f086d961129f099d9a))


### Features

* add option to skip dev environment deploy by env var or commit msg ([e098e9a](https://gitlab.com/xebis/infrastructure-template/commit/e098e9ab1d4e12e69a1e4d140b5fd21b41a92526))
* add script deciding whether to create dev environment or not ([74a8535](https://gitlab.com/xebis/infrastructure-template/commit/74a85354c2cef1746548348c53d42e9bf2d999fb))
* create dev env only for non-push, update it when already exists ([1fd3329](https://gitlab.com/xebis/infrastructure-template/commit/1fd33296611bbf2c1de96afc611ef68cadc6b7a1))

# [0.3.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.2.0...v0.3.0) (2021-11-24)


### Features

* add load-secrets script and other repository-template improvements ([b3b2071](https://gitlab.com/xebis/infrastructure-template/commit/b3b2071d39c33fcd5238e6545cafee260b56101c))

# [0.2.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.1.1...v0.2.0) (2021-11-14)


### Features

* mrs (prs) not blocked by undestroyed development environment ([83a4673](https://gitlab.com/xebis/infrastructure-template/commit/83a4673d99bd2021995b66f15ea3e29335a507ca))

## [0.1.1](https://gitlab.com/xebis/infrastructure-template/compare/v0.1.0...v0.1.1) (2021-11-14)


### Bug Fixes

* release tag shouldn't have skip ci flag ([81e2444](https://gitlab.com/xebis/infrastructure-template/commit/81e2444c1092413b030ac5aa3ea79011c65521e2))

# [0.1.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.0.0...v0.1.0) (2021-11-13)


### Bug Fixes

* terraform backend fails from gitlab ci ([3c08c82](https://gitlab.com/xebis/infrastructure-template/commit/3c08c822ff1f9c6dcc7c7360b4fa6febaafdf1fe))


### Features

* add gitlab ci environments ([236559f](https://gitlab.com/xebis/infrastructure-template/commit/236559f2a626ff7634fd3b65f6660cf08a8dbc80))
* add gitlab ci environments update stubs ([92fde0a](https://gitlab.com/xebis/infrastructure-template/commit/92fde0acb8a089fac1ee46137ae8e5bcbfb1013e))
* add repository-template ([23c68fd](https://gitlab.com/xebis/infrastructure-template/commit/23c68fdcf7f106bcecb180c5bcf6de306df7cb98))
* add terraform to ci ([00bae5b](https://gitlab.com/xebis/infrastructure-template/commit/00bae5bb746617cf5e6cb9adafcb9f19d6c598fc))
* add terraform, hetzner provider, tflint, and checkov ([d5c2d02](https://gitlab.com/xebis/infrastructure-template/commit/d5c2d02e62afed504759e7bbe616a109ef810c24))
* add testing and development environments destroy jobs ([9fb5a84](https://gitlab.com/xebis/infrastructure-template/commit/9fb5a84a3589547db9b5aecfb645f86731e3edd3))
