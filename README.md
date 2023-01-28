# bpsh

A Bash script which uses [Cloud Native Buildpacks](https://buildpacks.io/)
and [Podman](https://podman.io/) to create a runnable app image from source code.

`bpsh` calls the CNB [lifecycle](https://buildpacks.io/docs/concepts/components/lifecycle/)
commands from within a [builder](https://buildpacks.io/docs/concepts/components/builder/)
container to build or rebase images.

It does not rely on the [Pack CLI](https://buildpacks.io/docs/tools/pack/).

## Requirements

* [GNU bash](https://www.gnu.org/software/bash/) 4+
* [Podman](https://podman.io/)

## Install

```
wget https://raw.githubusercontent.com/jfhovinne/bpsh/master/bpsh && chmod +x bpsh
```

## Usage

```
$ bpsh
bpsh - A shell script for Cloud Native Buildpacks using Podman and CNB lifecycle commands

Usage:
  bpsh COMMAND
  bpsh [COMMAND] --help | -h
  bpsh --version | -v

Commands:
  build    Use Cloud Native Buildpacks to create a runnable app image from source code
  rebase   Rebase app image with latest run image
```

### Build

```
$ bpsh build --help
bpsh build - Use Cloud Native Buildpacks to create a runnable app image from source code

Alias: b

Usage:
  bpsh build IMAGE [OPTIONS]
  bpsh build --help | -h

Options:
  --help, -h
    Show this help

  --path, -p PATH
    Path to app dir
    Default: .

  --builder, -B BUILDER
    Builder image
    Default: docker.io/paketobuildpacks/builder

  --authfile AUTHFILE
    Path to file containing registry credentials

Arguments:
  IMAGE
    The name of the image that will be built

Examples:
  bpsh build foo/goapp --path /path/to/foo/goapp
  bpsh build bar/phpapp --builder docker.io/paketobuildpacks/builder:full
  bpsh build foo/bar --authfile $HOME/.docker/config.json
```

### Rebase

```
$ bpsh rebase --help
bpsh rebase - Rebase app image with latest run image

Alias: r

Usage:
  bpsh rebase IMAGE [OPTIONS]
  bpsh rebase --help | -h

Options:
  --help, -h
    Show this help

  --builder, -B BUILDER
    Builder image
    Default: docker.io/paketobuildpacks/builder

  --authfile AUTHFILE
    Path to file containing registry credentials

Arguments:
  IMAGE
    The name of the image to rebase

Examples:
  bpsh rebase foo/bar --authfile $HOME/.docker/config.json
```
