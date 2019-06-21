# source{d} Helm charts
This repository contains all [Helm charts](https://helm.sh/docs/developing_charts/) for source{d} products as well as charts internally used.
The charts are split up in 3 categories: stable, incubator and infra. Stable contains all charts for source{d} products and most of their dependancies. Incubator contain new not well tested charts. Infra contains all charts used by the source{d} infrastructure team.

Our charts target the latest Helm release and Kubernetes v1.11 or higher unless otherwise noted in the chart.

## Use charts
To use the chars hosted here you need to add this repo as a Helm repo using the `helm repo add` command.
```bash
$ helm repo add srcd-stable https://src-d.github.io/charts/stable/
$ helm repo add srcd-incubator https://src-d.github.io/charts/incubator/
$ helm repo add srcd-infra https://src-d.github.io/charts/infra/
```

## Chart guidelines
To create a new chart we use `helm create <chart name>`. Charts are [tested and linted](docs/tests.md) inside Travis CI in push and PR.
All charts need to contain the following in the `Chart.yaml` file: `apiVersion`, `name`, `version`, `appVersion`, `description`, `home` and `maintainers`.
Should a chart have optional values these should be documented using a comment inside the `values.yaml` file, should one of these be required it should be set in `ci/test-values.yaml` for the tests to pass.

## Contribute

[Contributions](https://github.com/src-d/{project}/issues) are more than welcome, if you are interested please take a look to
our [Contributing Guidelines](CONTRIBUTING.md).

## Code of Conduct

All activities under source{d} projects are governed by the [source{d} code of conduct](https://github.com/src-d/guide/blob/master/.github/CODE_OF_CONDUCT.md).

## License
Apache License Version 2.0, see [LICENSE](LICENSE).
