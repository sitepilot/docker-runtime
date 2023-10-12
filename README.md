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

* https://github.com/sitepilot/docker-php
* https://github.com/sitepilot/docker-lsphp

## Filesystem

⚠️ The `/runtime` folder should **never** be mounted to a volume.

### Folders

| Folder                  | Description                                                                            |
|-------------------------|----------------------------------------------------------------------------------------|
| `/runtime/bin`          | Contains executable files used for building and running the container.                 |
| `/runtime/command.d`    | Each file in this folder is executed before the default container command is executed. |
| `/runtime/entrypoint.d` | Each file in this folder is executed before the container command is executed.         |
| `/runtime/inc`          | Contains helper files for bash scripts an generating templates.                        |
| `/runtime/logs`         | Contains temporary container log files.                                                |
| `/runtime/run`          | Contains temporary container pid-files.                                                |
| `/runtime/templates`    | Contains configuration templates.                                                      |

### Files

| File                            | Description                                                                                                                        |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| `/runtime/bin/cmd`              | Default `CMD` script which executes each script in the `command.d` folder before running the command given as parameter.           |
| `/runtime/bin/entrypoint`       | Default `ENTRYPOINT` script which executes each script in the `entrypoint.d` folder before running the command given as parameter. |
| `/runtime/bin/finalize`         | Restores file permissions after a container build.                                                                                 |
| `/runtime/bin/install`          | Installs packages and clean up cache.                                                                                              |
| `/runtime/command.d/10-logo.sh` | Displays the logo on container start.                                                                                              |
| `/runtime/command.d/20-info.sh` | Displays container info on container start.                                                                                        |
| `/runtime/command.d/30-info.sh` | Initializes applications folders.                                                                                                  |
| `/runtime/inc/bash-functions`   | Contains useful bash functions.                                                                                                    |
| `/runtime/inc/template-filters` | Contains useful template filters.                                                                                                  |

## Environment

| Folder                   | Value                   | Description                                |
|--------------------------|-------------------------|--------------------------------------------|
| `RUNTIME_UID`            | `1000`                  | The ID of the container user.              |
| `RUNTIME_GID`            | `1000`                  | The ID of the container user group.        |
| `RUNTIME_USER`           | `app`                   | The name of the container user.            |
| `RUNTIME_GROUP`          | `app`                   | The name of the container user group.      |
| `RUNTIME_DIR`            | `/runtime`              | Path to the runtime folder.                |
| `RUNTIME_BIN_DIR`        | `/runtime/bin`          | Path to the runtime `bin` folder.          |
| `RUNTIME_INC_DIR`        | `/runtime/inc`          | Path to the runtime `inc` folder.          |
| `RUNTIME_RUN_DIR`        | `/runtime/run`          | Path to the runtime `run` folder.          |
| `RUNTIME_LOGS_DIR`       | `/runtime/logs`         | Path to the runtime `logs` folder.         |
| `RUNTIME_TEMPLATES_DIR`  | `/runtime/templates`    | Path to the runtime `templates` folder.    |
| `RUNTIME_COMMAND_DIR`    | `/runtime/command.d`    | Path to the runtime `command.d` folder.    |
| `RUNTIME_ENTRYPOINT_DIR` | `/runtime/entrypoint.d` | Path to the runtime `entrypoint.d` folder. |
