# shellcheck-buildkite-plugin
Shell script linter plugin for Buildkite

[![Build status](https://badge.buildkite.com/c00862681e75d87436590fe047fab7ef179142ebdacd3c40c0.svg?branch=master)](https://buildkite.com/operable/shellcheck-buildkite-plugin)

**NOTE: This plugin is a work-in-progress. We use it internally at Operable to test our bundles. However, it may still blow up your systems; use at your own discretion!**

This plugin allows you to lint your shell scripts using [shellcheck](https://github.com/koalaman/shellcheck). It is implememnted in terms of the Docker image for `shellcheck`, so it must be run on a build agent that has access to `docker`.

## Keys
* `script`: specify the script (or scripts) to lint. Each file is linted individually.
* `opts`: space-separated string of command-line options for `shellcheck`; corresponds to the `SHELLCHECK_OPTS` environment variable.

   Useful options for the purposes of this plugin include `--exclude` (to exclude specific checks) and `--shell` (to specify a scripting dialect).

   All options available can be seen by running `shellcheck` without any arguments, e.g.:

```sh
docker run --rm -t koalaman/shellcheck
No files specified.

Usage: shellcheck [OPTIONS...] FILES...
  -e CODE1,CODE2..  --exclude=CODE1,CODE2..  exclude types of warnings
  -f FORMAT         --format=FORMAT          output format
  -C[WHEN]          --color[=WHEN]           Use color (auto, always, never)
  -s SHELLNAME      --shell=SHELLNAME        Specify dialect (sh,bash,dash,ksh)
  -x                --external-sources       Allow 'source' outside of FILES.
  -V                --version                Print version information
```

Codes for the warnings can be found in the [shellcheck wiki](https://github.com/koalaman/shellcheck/wiki).

## Usage

```yaml
- steps
  - label: Simple linting
    plugins:
      - operable/shellcheck:
          script: my_script.sh

  - label: Lint multiple scripts
    plugins:
      - operable/shellcheck:
          script:
            - my_script.sh
            - my_other_script.sh
            - yet_another_script.sh

  - label: Exclude some warnings
    plugins:
      - operable/shellcheck:
          script: my_script.sh
          opts: --exclude=1000
```

Also see this plugin's [pipeline configuration](.buildkite/pipeline.sh) for other examples.
