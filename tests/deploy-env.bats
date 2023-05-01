#!/usr/bin/env bash
# shellcheck disable=SC2030,SC2031,SC2317
set -euo pipefail
IFS=$'\n\t'
LANG=C

setup() {
    load 'helpers/bats-support/load'
    load 'helpers/bats-assert/load'

    export TEST_ARGV=('scripts/deploy-env')

    unset CREATE_ENV ENV_CREATE
    unset SKIP_ENV ENV_SKIP

    . scripts/deploy-env
}

@test 'scripts/deploy-env deploy_env prod environment' {
    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='production'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env stag environment' {
    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='staging'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env test environment' {
    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='testing'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment exists test' {
    function curl() {
        echo '200'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment exists with skip env variable test' {
    function curl() {
        echo '200'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_COMMIT_MESSAGE='test: under test'
    export SKIP_ENV='true'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment exists with skip env commit test' {
    function curl() {
        echo '200'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_COMMIT_MESSAGE='test: under test [skip env]'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and push pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='push'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and scheduled pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='schedule'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and api pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='api'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and web pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='web'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and push pipeline with create env variable test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='push'
    export CI_COMMIT_MESSAGE='test: under test'
    export CREATE_ENV='true'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and scheduled pipeline with env create variable test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='schedule'
    export CI_COMMIT_MESSAGE='test: under test'
    export ENV_CREATE='true'

    run deploy_env

    assert_success
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and triggered pipeline with skip env test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='trigger'
    export CI_COMMIT_MESSAGE='test: under test'
    export SKIP_ENV='true'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and web pipeline with create env variable with env skip variable test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='web'
    export CI_COMMIT_MESSAGE='test: under test'
    export CREATE_ENV='true'
    export ENV_SKIP='true'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment does not exist and api pipeline with create env variable with env skip commit test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'
    export CI_PIPELINE_SOURCE='api'
    export CI_COMMIT_MESSAGE="test: under test

This commit should skip environment create or update by adding [eNv SkIp]!"
    export ENV_CREATE='true'

    run deploy_env

    assert_failure
    refute_output
}

@test 'scripts/deploy-env deploy_env dev environment error test' {
    function curl() {
        echo '503'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_ENVIRONMENT_TIER='development'

    run deploy_env

    assert_failure
    assert_output "scripts/deploy-env ✗ Terraform state at 'https://example.com/tf/test' returns HTTP status code '503'"
}

@test 'scripts/deploy-env deploy_env other environment' {
    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='other'
    export CI_ENVIRONMENT_TIER='testing'
    export CI_COMMIT_MESSAGE='test: under test'

    run deploy_env

    assert_success
    refute_output
}
