#!/usr/bin/env bash

function help() {
  cat <<EOF
Usage: $(basename "${0}") [--dry-run] [PART]
Arguments:
  PART            The part of the semver version to bump: major, minor, or patch
                  Default: patch
Options:
  -h | --help     Print this usage guide.
  -d | --dry-run  Do a dry run and print what the version bump would do
Note:
  This script requires bump2version -- https://pypi.org/project/bump2version/

EOF
}

PART=patch
while [[ ${#} -gt 0 ]]; do
  argument="${1}"
  case ${argument} in
    -h|--help)
      help
      exit 0
      shift "${#}" ;; # past all remaining args
    -d|--dry-run)
      ARGUMENTS="--dry-run"
      shift 1 ;;
    major|minor|patch)
      PART=${1}
      shift 1 ;;
    *)
      remainder="${*}"
      shift "${#}" ;; # past all remaining args
  esac
done


# Check for bump2version and try to install if necessary
if ! command -v bump2version; then
  if ! pip install bump2version update -qq; then
    >&2 echo "Failed to install bump2version. Do you even have pip installed?"
  fi
fi


# Bump version
if ! bump2version ${ARGUMENTS} --list --allow-dirty ${PART}; then
  >&2 echo
  >&2 echo "ERROR: Failed to bump version."
else
  echo "SUCCESS: Version is now set to $(cat ./VERSION)."
fi
