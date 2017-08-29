# Drone.io

[Drone](http://readme.drone.io/) is a Continuous Integration platform built on container technology. Every build is executed inside an ephemeral Docker container, giving developers complete control over their build environment with guaranteed isolation.

## Introduction

This chart stands up a Drone server. This includes:

- A [Drone Server](http://readme.drone.io/admin/installation-guide/) Pod
- A [Drone Agent](http://readme.drone.io/admin/installation-guide/) Pod

## Prerequisites

- Kubernetes 1.5+
- The ability to point a DNS entry or URL at your Drone installation

## Installing the Chart

To install the chart, run:

```bash
$ helm install --name <release-name> <path-to-chart> --set \
  secrets.drone_secret=<secret-key>,\
  secrets.github_client=<client-id>,\
  secrets.github_secret=<client-secret>,\
  ingress.hostname=<hostname>,\
  ingress.globalStaticIpName=<static-ip>,\
  server.env.admins=<admin1\,admin2\,..>
```

These are the mandatory parameters that need to be provided or installation will fail.
Other parameters can be provided too but, if not, a default value will be used.

`<secret-key>` is a key that Drone agents internally use to talk to Drone server.
It can be whatever string you choose but it must not be changed when using `helm upgrade`,
or agents and server could end up using different keys.

The GitHub parameters (`<client-id>` and `<client-secret>`), need to be the ones obtained when [registering drone](http://readme.drone.io/admin/setup-github/) as an OAuth application in GitHub (done under `jbeardly`'s identity).

## Configuration

These tables show some relevant Drone environment variables and the default value that we are assigning in [values.yaml](values.yaml).

| Server's ENV variable        | Description                            | Default                                               |
| ---------------------------- | -------------------------------------- | ----------------------------------------------------- |
| `DRONE_DATABASE_DRIVER`      | Database driver name                   | `sqlite3`                                             |
| `DRONE_DATABASE_DATASOURCE`  | Database connection string             | `/var/lib/drone/drone.sqlite`                         |
| `DRONE_OPEN`                 | If registration is open or not         | `true`                                                |
| `DRONE_GITHUB`               | Enables/disables GitHub driver         | `true`                                                |
| `DRONE_ADMIN`                | Comma-separated list of admin users    | Dynamically build. Do not override.                   |
| `DRONE_SECRET`               | Shared secret. Agents' must match.     | Dynamically build. Do not override.                   |
| `DRONE_GITHUB_CLIENT`        | Github oauth2 client id                | Dynamically build. Do not override.                   |
| `DRONE_GITHUB_SECRET`        | Github oauth2 client secret            | Dynamically build. Do not override.                   |
| `DRONE_HOST`                 | URL for drone server                   | Dynamically build. Do not override.                   |                                     |


| Agent's ENV variable         | Description                            | Default                                               |
| ---------------------------- | -------------------------------------- | ----------------------------------------------------- |
| `DRONE_SECRET`               | Shared secret. Server's must match.    | Dynamically build. Do not override.                   |
| `DRONE_SERVER`               | Full URL (with protocol) to the server | Dynamically build. Do not override.                   |
| `DOCKER_API_VERSION`         | Must be <= to host's engine version    | `1.23`                                                |


Apart from the Drone environment variables, there are other important settings used in this chart:

| Parameter                    | Description                            | Default                                               |
| ---------------------------- | -------------------------------------- | ----------------------------------------------------- |
| `ingress.hostname`           | DNS for drone server                   | (*)                                                   |
| `ingress.globalStaticIpName` | Static IP (GCE resource's name)        | (*)                                                   |
| `server.admins`              | Comma-separated list of admin users    | (*)                                                   |
| `server.db_path`             | Persistent disk mounting point         | `/var/lib/drone`                                      |
| `server.db_disk`             | GCE persistent disk GKE name           | `data-prod-drone`                                     |
| `agent.num_instances`        | Number of Drone agents                 | `1`                                                   |
| `secrets.drone_secret`       | Drone shared secret                    | (*)                                                   |
| `secrets.github_client`      | Github oauth2 client id                | (*)                                                   |
| `secrets.github_secret`      | Github oauth2 client secret            | (*)                                                   |

* (*) No default value. It must be provided in the intallation command line with `--set `. See previous section.

Please refer to [values.yaml](values.yaml) for the full run-down on defaults. These are a mixture
of Kubernetes and drone directives.

To override any of those default values, specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example,

```bash
$ helm install --name <release-name> -f values.yaml <path-to-chart>
```

> **Tip**: You can use the default [values.yaml](values.yaml)
