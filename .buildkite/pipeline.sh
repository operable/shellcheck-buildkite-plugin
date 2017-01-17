#!/bin/bash

set -eu

# We have to use cat because pipeline.yml $ interpolation doesn't work in YAML
# keys, only values
cat <<YAML
steps:

  - label: Check the hook script
    plugins:
      operable/shellcheck#${BUILDKITE_COMMIT}:
        script: hooks/command

  - label: Check multiple scripts at once
    plugins:
      operable/shellcheck#${BUILDKITE_COMMIT}:
        script:
          - hooks/command
          - test/do_something.sh
          - test/do_something_else.sh

  - label: Can specify options
    plugins:
      operable/shellcheck#${BUILDKITE_COMMIT}:
        script: test/do_something_bad.sh
        opts: --exclude=2068

YAML
