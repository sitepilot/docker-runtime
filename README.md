# Docker Runtime

Docker Runtime is an optimized and extendable container image for developing application and service containers.

You can use the image directly, e.g.

```
docker run --rm -it ghcr.io/sitepilot/runtime:1.x bash
```

You can also use the images as a base for your own Dockerfile:

```
FROM ghcr.io/sitepilot/runtime:1.x bash
```

Example implementations:

* [https://github.com/sitepilot/docker-php](https://github.com/sitepilot/docker-php/blob/1.x/src/Dockerfile)
* [https://github.com/sitepilot/docker-lsphp](https://github.com/sitepilot/docker-lsphp/blob/1.x/src/Dockerfile)

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

| Folder                   | Value                   | Description                                                                    |
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
