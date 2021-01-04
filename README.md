# miniauth

A simple authenticated Flask API for simple tests.

## Running miniapi

### Prerequisites
This app has been tested with Python 3.9. To install Python module prerequisites, run:
```shell
$ pip3 install -r ./requirements.txt
```

### Running Locally

To run the API service directly, run:
```shell
$ ./miniapi/app.py
```

The API service will listen on 0.0.0.0 and port 5000. You can reach the app at [http://localhost:5000/](http://localhost:5000/).

### Running in Docker

To build the Docker container, run:

```shell
$ docker build . -t miniapi
```

And to run it, run:
```shell
$ docker run -p 5000:5000 -n miniapi --rm -d miniapi
```

You can reach the container at [http://localhost:5000/](http://localhost:5000/).

To stop the container, run:
```shell
$ docker stop miniapi
```

## Local Development

### Pushing Docker Containers
As a convenience, the script `./scripts/docker-build.sh` may be used to build and push the miniapi container to Docker Hub. To use it, first log on to docker hub.
```shell
$ docker login
```

Then run the `./scripts/docker-build.sh` script with the name of the container image you wish to push. The script will first build and then push the container with both the `:latest` and `:<version>` tag as described below in [Versioning](#Versioning).
```shell
$ ./scripts/docker-build.sh zconger/miniapi
```

### Versioning

The `VERSION` file at the base of this repo contains the semver version number for the container that will be built by `./scripts/docker-build.sh`. This script will run via GitHub Actions whenever the `master` branch is pushed to GitHub. You can run it manually to build and push the `away168/rps` container like so:

```shell
$ ./scripts/docker-build.sh
```

For convenience, you can use the script `./scripts/bump-version.sh` to update the `VERSION` file. This script depends on the Python script [bump2version](https://pypi.org/project/bump2version/). The configuration file for `bump2version` is found in this repo at `./.bumpversion.cfg`.

### `bump-version` Examples

Get help:
```shell
$ ./scripts/bump-version.sh --help
Usage: bump-version.sh [--dry-run] [PART]
Arguments:
  PART            The part of the semver version to bump: major, minor, or patch
                  Default: patch
Options:
  -h | --help     Print this usage guide.
  -d | --dry-run  Do a dry run and print what the version bump would do
Note:
  This script requires bump2version -- https://pypi.org/project/bump2version/
```

Try a dry run patch bump. The version will *not* be updated with a dry run:
```shell
$ ./scripts/bump-version.sh --dry-run
/usr/local/bin/bump2version
current_version=1.0.4
new_version=1.0.5
SUCCESS: Version is now set to 1.0.4.
```

## GitHub Actions Workflow

This repository contains a GitHub Actions workflow at `./.github/workflows/container-push.yml`. It is configured to run any time a commit is pushed to either the `master` or `main` branch. For it to work in your environment, you must add the following secrets to your GitHub repository:

    - `DOCKER_USERNAME`: Your Docker Hub username
    - `DOCKER_PASSWORD`: Your Docker Hub password or access token

You must also specify the name of the container image you wish to push in the `jobs.push_to_registry.env.IMAGE_NAME` setting in `./.github/workflows/container-push.yml`. This environment variable is set to `zconger/miniapi` by default, which won't work without my Docker Hub credentials!

*Thank you!*
*--Zachary*
