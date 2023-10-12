# Docker Runtime Image

This image is used as a base image for all of our Docker images.

## Filesystem

### Application

ℹ️ The `/app` folder may be mounted to a volume to persist data between container restarts.

#### Folders

| Folder        | Description                                                           |
|---------------|-----------------------------------------------------------------------|
| `/app/files`  | Contains application files (e.g. a WordPress, Laravel or NodeJS app). |
| `/app/logs`   | Contains application log / debug files (e.g. a PHP-debug log).        |
| `/app/config` | Contains application config files (e.g. a webserver SSL-certificate). |

### Runtime

⚠️ The `/runtime` folder should **never** be mounted to a volume.

#### Folders

| Folder                  | Description                                                                            |
|-------------------------|----------------------------------------------------------------------------------------|
| `/runtime/bin`          | Contains executable files for building and running the container.                      |
| `/runtime/command.d`    | Each file in this folder is executed before the default container command is executed. |
| `/runtime/entrypoint.d` | Each file in this folder is executed before the container command is executed.         |
| `/runtime/inc`          | Contains helper files for generating templates and running scripts.                    |
| `/runtime/logs`         | Contains temporary log files which are removed on every container restart.             |
| `/runtime/run`          | Contains service pid-files which are removed on every container restart.               |
| `/runtime/run`          | Contains service templates which will be generated on container startup.               |

#### Files

| Folder                          | Description                                                                          |
|---------------------------------|--------------------------------------------------------------------------------------|
| `/runtime/bin/command`          | Default `CMD` script which executes each script in the `command.d` folder.           |
| `/runtime/bin/entrypoint`       | Default `ENTRYPOINT` script which executes each script in the `entrypoint.d` folder. |
| `/runtime/bin/finalize`         | Resets file permissions after container build.                                       |
| `/runtime/bin/install`          | Installs apt-packages and cleans up cache.                                           |
| `/runtime/command.d/10-logo.sh` | Displays the logo on container start.                                                |
| `/runtime/command.d/20-info.sh` | Displays container info on container start.                                          |
| `/runtime/command.d/30-info.sh` | Initializes applications folders.                                                    |
| `/runtime/inc/bash-functions`   | Contains useful bash functions.                                                      |
| `/runtime/inc/template-filters` | Contains useful template filters.                                                    |

## Environment

| Folder                   | Description                                |
|--------------------------|--------------------------------------------|
| `APP_DIR`                | Path to the application folder.            |
| `APP_LOGS_DIR`           | Path to the application `logs` folder.     |
| `APP_FILES_DIR`          | Path to the application `files` folder.    |
| `APP_CONFIG_DIR`         | Path to the application `config` folder.   |
| `RUNTIME_UID`            | The ID of the container user.              |
| `RUNTIME_GID`            | The ID of the container user group.        |
| `RUNTIME_USER`           | The name of the container user.            |
| `RUNTIME_GROUP`          | The name of the container user group.      |
| `RUNTIME_DIR`            | Path to the runtime folder.                |
| `RUNTIME_BIN_DIR`        | Path to the runtime `bin` folder.          |
| `RUNTIME_INC_DIR`        | Path to the runtime `inc` folder.          |
| `RUNTIME_RUN_DIR`        | Path to the runtime `run` folder.          |
| `RUNTIME_LOGS_DIR`       | Path to the runtime `logs` folder.         |
| `RUNTIME_TEMPLATES_DIR`  | Path to the runtime `templates` folder.    |
| `RUNTIME_COMMAND_DIR`    | Path to the runtime `command.d` folder.    |
| `RUNTIME_ENTRYPOINT_DIR` | Path to the runtime `entrypoint.d` folder. |
