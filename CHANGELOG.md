## [0.19.1](https://gitlab.com/xebis/infrastructure-template/compare/v0.19.0...v0.19.1) (2022-11-17)


### Bug Fixes

* speed up nftables service check ([b961571](https://gitlab.com/xebis/infrastructure-template/commit/b961571c5ce5148e4b4f351b58b2f51703753de1))

# [0.19.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.18.1...v0.19.0) (2022-10-10)


### Bug Fixes

* add missing dependencies between ansible roles ([869253b](https://gitlab.com/xebis/infrastructure-template/commit/869253b03827ea58dd788bc0752ef13538bc7ce2))


### Features

* add common deb packages installation ([e6c2042](https://gitlab.com/xebis/infrastructure-template/commit/e6c2042efd49288e0ea3485e974499fb609e177e))
* add host/group/etc. config to log rejected packets by fw rules ([34c2591](https://gitlab.com/xebis/infrastructure-template/commit/34c25919c06cc0a910dde91587031ac341c7f8f0))

## [0.18.1](https://gitlab.com/xebis/infrastructure-template/compare/v0.18.0...v0.18.1) (2022-09-16)


### Bug Fixes

* each user should have own group, fix admin to sudo ([849c71f](https://gitlab.com/xebis/infrastructure-template/commit/849c71fcacd58d2e5a3d093e1517f1fe6b9d92d0))

# [0.18.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.17.0...v0.18.0) (2022-09-07)


### Features

* harden ssh security - disable all and empty passwords login ([7194d61](https://gitlab.com/xebis/infrastructure-template/commit/7194d6133ea1ac056bd811984db0c6ac28cf8ca0))

# [0.17.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.16.0...v0.17.0) (2022-09-06)


### Features

* disable root login via ssh ([8548b70](https://gitlab.com/xebis/infrastructure-template/commit/8548b70c92222b882237b2cbff1e14350d2b985c))

# [0.16.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.15.4...v0.16.0) (2022-09-05)


### Bug Fixes

* ansible role access fails on wrong expression ([9fe7fcb](https://gitlab.com/xebis/infrastructure-template/commit/9fe7fcb1df386304717a262aea579ff809b083b8))
* ansible role access fails on wrong loop expression ([3013a3b](https://gitlab.com/xebis/infrastructure-template/commit/3013a3ba6a6f81786bac1e203b4340ddd3f0da39))
* ansible role access fails on wrong user expression ([1abdd7b](https://gitlab.com/xebis/infrastructure-template/commit/1abdd7be2af2d68b2bc443589f1d662612c263ac))


### Features

* add role access configuring admins, users, and ssh keys ([313231c](https://gitlab.com/xebis/infrastructure-template/commit/313231cb9e7b2e860a8be38a560b37ce3d26f88d))
* add script bootstrap ansible.posix installation ([372d755](https://gitlab.com/xebis/infrastructure-template/commit/372d75536c145e314328a566fa6511dca0ed8e47))

## [0.15.4](https://gitlab.com/xebis/infrastructure-template/compare/v0.15.3...v0.15.4) (2022-08-30)


### Bug Fixes

* role firewall fails in ansible check mode on asynchronous task ([7caa7d5](https://gitlab.com/xebis/infrastructure-template/commit/7caa7d5177faae951fd6fb8d2409580e9ee3aaf7))

## [0.15.3](https://gitlab.com/xebis/infrastructure-template/compare/v0.15.2...v0.15.3) (2022-08-22)


### Bug Fixes

* ci job config ansible hangs when starting nftables ([388d8bc](https://gitlab.com/xebis/infrastructure-template/commit/388d8bc2ad61730927b1007891bcfa0f6e0de4d5))

## [0.15.2](https://gitlab.com/xebis/infrastructure-template/compare/v0.15.1...v0.15.2) (2022-01-29)


### Bug Fixes

* ansible lint complains about cache and tests dir content ([e4e4d2b](https://gitlab.com/xebis/infrastructure-template/commit/e4e4d2b5b7b1ae7a4341bc0ecd73ab0defe87bd9))

## [0.15.1](https://gitlab.com/xebis/infrastructure-template/compare/v0.15.0...v0.15.1) (2022-01-22)


### Bug Fixes

* firewall service name to enable and start ([dd09804](https://gitlab.com/xebis/infrastructure-template/commit/dd098045fae13383c88b1e9c5e7fa1dbb804e54f))
* nftables fails on shebang interpreted as one command ([c3fce87](https://gitlab.com/xebis/infrastructure-template/commit/c3fce876045c89db6f3f2d8e794d12523ca16ada))
* tf var env_tier default value fails on validation ([8b15b7a](https://gitlab.com/xebis/infrastructure-template/commit/8b15b7a457dcf0c737ce19591717531ee7903b86))

# [0.15.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.14.0...v0.15.0) (2022-01-22)


### Features

* separate terraform doc to docs/tf.md ([8c938d1](https://gitlab.com/xebis/infrastructure-template/commit/8c938d12aa2686d75ce220cc3a7e0317bc572eab))

# [0.14.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.13.0...v0.14.0) (2022-01-22)


### Features

* tf tries to guess env tier from env slug when empty ([4e25d49](https://gitlab.com/xebis/infrastructure-template/commit/4e25d499fca6d20da1e9a8c1fba2b03260a6356e))

# [0.13.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.12.1...v0.13.0) (2022-01-17)


### Features

* add nftables ([29bed15](https://gitlab.com/xebis/infrastructure-template/commit/29bed1571061716117dc5eb1fb2fecd9e200b39a))

## [0.12.1](https://gitlab.com/xebis/infrastructure-template/compare/v0.12.0...v0.12.1) (2022-01-15)


### Bug Fixes

* terraform readme docs reformat fails ci lint job ([cbabf0b](https://gitlab.com/xebis/infrastructure-template/commit/cbabf0b1d7327caed544e9e4d3d0d524661f49cc))

# [0.12.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.11.0...v0.12.0) (2022-01-13)


### Features

* add terraform-docs ([70cf1a1](https://gitlab.com/xebis/infrastructure-template/commit/70cf1a1cb728c3d2bd53c9cf080fd810de9fc37e))

# [0.11.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.10.0...v0.11.0) (2022-01-11)


### Features

* destroy dev env should work on deleted branches as well ([7fb69a4](https://gitlab.com/xebis/infrastructure-template/commit/7fb69a40c99673664c7f40d5570d1f0dd8152ff7))
* destroy test env should work on deleted branches as well ([bd4c5ef](https://gitlab.com/xebis/infrastructure-template/commit/bd4c5efbf317dc5b9dd0bd56119dbc118dfa52f2))

# [0.10.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.9.0...v0.10.0) (2022-01-11)


### Features

* fail2ban ([ffe42a2](https://gitlab.com/xebis/infrastructure-template/commit/ffe42a21c73589fe0bf03c80ccad886e368e2dce))

# [0.9.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.8.0...v0.9.0) (2022-01-10)


### Features

* add ansible dynamic inventory plugin for the hetzner cloud ([b211537](https://gitlab.com/xebis/infrastructure-template/commit/b2115376876d525b1dbc27acafc745effae852c6))

# [0.8.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.7.0...v0.8.0) (2022-01-09)


### Features

* common role updates packages and eventually reboots ([d23243b](https://gitlab.com/xebis/infrastructure-template/commit/d23243b8d3bd5b8748e753f23c1e568305d754ec))
* revert dev env run only on tf and ansible changed files ([e392867](https://gitlab.com/xebis/infrastructure-template/commit/e39286793d1bc01d891f5574cf58a46881387c17))

# [0.7.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.6.0...v0.7.0) (2022-01-08)


### Features

* rewrite dev-env, return from output to status, add unit tests ([1068598](https://gitlab.com/xebis/infrastructure-template/commit/106859883c3a559ac60db6762530355bc2cdf270))

# [0.6.0](https://gitlab.com/xebis/infrastructure-template/compare/v0.5.0...v0.6.0) (2021-12-01)


### Features

* create dev env from push or scheduled pipelines ([076da71](https://gitlab.com/xebis/infrastructure-template/commit/076da7154eb2b93ed2720aeb3bb37c92a06e3805))

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
