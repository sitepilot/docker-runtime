# Docker Runtime

Docker Runtime is an optimized and extendable Ubuntu container image for developing application and service containers.

## Usage

To use this image as a base image and avoid potential breaking changes in your container builds, use the following 
image naming pattern in your`Dockerfile`:

```Dockerfile
FROM ghcr.io/sitepilot/runtime:{{release-version}}
```

The images are tagged according to Semantic Versioning (SemVer). Available releases can be found on the [releases page](https://github.com/sitepilot/docker-runtime/releases). For example, if you wish to customize version 1.x of the image:

```Dockerfile
# Guaranteed backward compatibility, new features and bug fixes.
FROM ghcr.io/sitepilot/runtime:1
```

```Dockerfile
# Guaranteed backward compatibility and bug fixes.
FROM ghcr.io/sitepilot/runtime:1.0
```

```Dockerfile
# Guaranteed backward compatibility and no updates.
FROM ghcr.io/sitepilot/runtime:1.0.0
```

## Versions

The following Runtime versions are available:

* [1.x](https://github.com/sitepilot/docker-runtime/tree/1.x) - Ubuntu 22.04 LTS

## Examples

You can find example implementations in the following repositories:

* [https://github.com/sitepilot/docker-php](https://github.com/sitepilot/docker-php/blob/1.x/src/Dockerfile)
* [https://github.com/sitepilot/docker-proxy](https://github.com/sitepilot/docker-proxy/blob/1.x/src/Dockerfile)

## Filesystem

⚠️ The `/runtime` folder should **never** be mounted to a volume.

### Folders

| Folder                  | Description                                                                    |
|-------------------------|--------------------------------------------------------------------------------|
| `/runtime/bin`          | Contains executable files used for building and running the container.         |
| `/runtime/entrypoint.d` | Each file in this folder is executed before the container command is executed. |
| `/runtime/inc`          | Contains helper files for bash scripts an generating templates.                |
| `/runtime/logs`         | Contains temporary container log files.                                        |
| `/runtime/run`          | Contains temporary container pid-files.                                        |
| `/runtime/templates`    | Contains configuration templates.                                              |

### Files

| File                               | Description                                                                                                                                                   |
|------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `/runtime/bin/runtime`             | Default `ENTRYPOINT` script which executes each script in the `entrypoint.d` folder before running container command.                                         |
| `/runtime/bin/rt-chown`            | Change the owner and group of a file (this allows services and scripts to access this file while running the container with a non-root user).                 |
| `/runtime/bin/rt-rchown`           | Recursively change the owner and group of a folder (this allows services and scripts to access this folder while running the container with a non-root user). |
| `/runtime/bin/rt-install`          | Installs packages and clean up cache.                                                                                                                         |
| `/runtime/entrypoint.d/10-init.sh` | Initialize the container user when running as root (e.g. name, group, password, uid, gid).                                                                    |
| `/runtime/entrypoint.d/20-logo.sh` | Displays the brand logo.                                                                                                                                      |
| `/runtime/entrypoint.d/30-info.sh` | Displays container info.                                                                                                                                      |
| `/runtime/inc/bash-functions`      | Contains useful bash functions.                                                                                                                               |
| `/runtime/inc/template-filters`    | Contains useful template filters.                                                                                                                             |

## Environment

The following environment variables are available:

| Name                     | Value                   | Description                                                                    |
|--------------------------|-------------------------|--------------------------------------------------------------------------------|
| `RUNTIME_UID`            | `1000`                  | The ID of the container user.                                                  |
| `RUNTIME_GID`            | `1000`                  | The ID of the container user group.                                            |
| `RUNTIME_USER`           | `app`                   | The container user name.                                                       |
| `RUNTIME_GROUP`          | `app`                   | The container user group.                                                      |
| `RUNTIME_PASSWORD`       | -                       | The container user password.                                                   |
| `RUNTIME_LOG_LEVEL`      | `1`                     | The container log level (`1` = debug, `2` = info, `3` = warning, `4` = error). |
| `RUNTIME_DIR`            | `/runtime`              | Path to the runtime folder.                                                    |
| `RUNTIME_WORKDIR`        | `/app`                  | Path to the container workdir (application root).                              |
| `RUNTIME_BIN_DIR`        | `/runtime/bin`          | Path to the runtime `bin` folder.                                              |
| `RUNTIME_INC_DIR`        | `/runtime/inc`          | Path to the runtime `inc` folder.                                              |
| `RUNTIME_RUN_DIR`        | `/runtime/run`          | Path to the runtime `run` folder.                                              |
| `RUNTIME_LOGS_DIR`       | `/runtime/logs`         | Path to the runtime `logs` folder.                                             |
| `RUNTIME_TEMPLATES_DIR`  | `/runtime/templates`    | Path to the runtime `templates` folder.                                        |
| `RUNTIME_ENTRYPOINT_DIR` | `/runtime/entrypoint.d` | Path to the runtime `entrypoint.d` folder.                                     |
| `RUNTIME_BOOTED_FILE`    | `/runtime/booted`       | Path to the runtime `booted` file.                                             |
