# Sitepilot Runtime

Docker runtime image used for running web applications on the Sitepilot managed hosting platform.

## Volumes

To persist your data you need to mount `/opt/sitepilot/app` to a Docker volume or local folder.

## Ports

The Openlitespeed webserver is listening to port `8080` (http) and `8443` (https).

## Configuration 

You can override the runtime configuration by creating / mounting a runtime configuration file to `/opt/sitepilot/config/runtime.yml`. The custom runtime configuration wil be merged with the default configuration.

[You can use the default runtime configuration file for reference.](filesystem/opt/sitepilot/runtime/defaults.yml)

## Auto Deployment

To automatically deploy your application after each push to GitHub, GitLab or BitBucket you need to configure a webhook. You can point your webhook to the following URL:

```
# GitHub
https://<url>/-/webhooks/github

# GitLab
https://<url>/-/webhooks/gitlab

# BitBucket
https://<url>/-/webhooks/bitbucket
```

Your code will be cloned after each push (to the configured deploy branch). After a successfull deployment the webserver wil be pointed to the new deployment directory and your updated code is served to your visitors without downtime.
