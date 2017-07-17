# Landing

This chart deploys [landing](https://github.com/src-d/landing) source{d} web page

## Pre-requisites

* Kubernetes 1.4+ with Beta APIs enabled
* nginx ingress controller

## Installing the chart

All parameters under `settings` in [values.yaml](/landing/values.yaml) must be provided.

```
helm install -n <release-name> <chart path> --set "\
settings.slackApiToken=TOKEN,\
settings.githubToken=TOKEN,\
settings.imagePullSecretDockerConfigJson=TOKEN,\
settings.loadBalancerIP=100.211.75.223,\
settings.hosts={srcd.run,www.srcd.run}\
"
```

## Implementation details

Landing currently consists of two docker containers:

* Static + API: A Caddy server listening in 8090 that serves static and forwards GitHub API traffic (/api) to a localhost server listening in 8080
* Slackin interaction: A nodeJS server running in port 3000 that handles Slack interaction

Two ingresses backends have been created:

* 80 -> 8090 for `/*`
* 80 -> 3000 for `/slackin/*`

`/api` requests will be handled by first backend as Caddy server will proxy things accordingly

`nginx` ingress controller has been used due to the need for rewriting paths to slackin backend
