# Rovers

This chart deploys [rovers](https://github.com/src-d/rovers)

## Pre-requisites

- Kubernetes 1.4+

## Installing the Chart

* To install Rovers giving all the secrets needed in the command line:

```sh
helm install --name rovers-release --set \
secrets.bingKey=<bing key>,\
secrets.githubToken=<github token>
```

* To install Rovers using an already deployed secret

```sh
helm install --name rovers-release --set secretName=<secret name>
```

## Configuration

See `values.yaml` for the available configuration parameters.

## Notes

This chart has a pre-install hook to create rovers database. Rovers code takes care that tables are only created if they don't exist
