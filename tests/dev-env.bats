#!/usr/bin/env bash
# shellcheck disable=SC2030,SC2031
set -euo pipefail
IFS=$'\n\t'
LANG=C

setup() {
    load 'helpers/bats-support/load'
    load 'helpers/bats-assert/load'

    export TEST_ARGV=('scripts/dev-env')

    . scripts/dev-env
}

@test 'scripts/dev-env dev_env environment exists test' {
    function curl() {
        echo '200'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_COMMIT_MESSAGE='test: under test'

    run dev_env

    assert_success
    refute_output
}

@test 'scripts/dev-env dev_env environment exists with skip env variable test' {
    function curl() {
        echo '200'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_COMMIT_MESSAGE='test: under test'
    export SKIP_ENV='true'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment exists with skip env commit test' {
    function curl() {
        echo '200'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_COMMIT_MESSAGE='test: under test [skip env]'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and push pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='push'
    export CI_COMMIT_MESSAGE='test: under test'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and scheduled pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='schedule'
    export CI_COMMIT_MESSAGE='test: under test'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and api pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='api'
    export CI_COMMIT_MESSAGE='test: under test'

    run dev_env

    assert_success
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and web pipeline test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='web'
    export CI_COMMIT_MESSAGE='test: under test'

    run dev_env

    assert_success
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and push pipeline with create env variable test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='push'
    export CI_COMMIT_MESSAGE='test: under test'
    export CREATE_ENV='true'

    run dev_env

    assert_success
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and scheduled pipeline with env create variable test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='schedule'
    export CI_COMMIT_MESSAGE='test: under test'
    export ENV_CREATE='true'

    run dev_env

    assert_success
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and triggered pipeline with skip env test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='trigger'
    export CI_COMMIT_MESSAGE='test: under test'
    export SKIP_ENV='true'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and web pipeline with create env variable with env skip variable test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='web'
    export CI_COMMIT_MESSAGE='test: under test'
    export CREATE_ENV='true'
    export ENV_SKIP='true'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment does not exist and api pipeline with create env variable with env skip commit test' {
    function curl() {
        echo '404'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'
    export CI_PIPELINE_SOURCE='api'
    export CI_COMMIT_MESSAGE="test: under test

This commit should skip environment create or update by adding [eNv SkIp]!"
    export ENV_CREATE='true'

    run dev_env

    assert_failure
    refute_output
}

@test 'scripts/dev-env dev_env environment error test' {
    function curl() {
        echo '503'
    }
    export -f curl

    export GL_TOKEN='******'
    export GL_TF_BE='https://example.com/tf'
    export CI_ENVIRONMENT_SLUG='test'

    run dev_env

    assert_failure
    assert_output "scripts/dev-env ✗ Terraform state at 'https://example.com/tf/test' returns HTTP status code '503'"
}
