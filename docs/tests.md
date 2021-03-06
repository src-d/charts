# Testing
To test our charts we have a 2 part testing setup. The first part is linting, charts get linted using the [chart-testing tool](https://github.com/helm/chart-testing) which lints all YAML files as well as checks if they are compliant to Helm's standards.
The second part are acceptance tests which are run by installing the chart on a Minikube Kubernetes cluster using the set of test values, these are then tested by a pod deployment running tests.

## Acceptance tests
Tests are stored in `<chart name>/templates/tests`, which are Helm templates deployed to the cluster to test. These consist of a Pod object which will be run on test that contains the setup for the test. To mark the test as success or fail, Helm will check the Pod's exit status. The test can also contain extra resources like configmaps (to store the tests in).
Since running these tests require installing the charts in a cluster an appropriate values file is needed. This can be one or multiple, they are stored in `<chart name>/ci` and have to end on `-values.yaml`. These are also used during linting to check the validity of the Helm template output.

## Writing tests
For charts with required values a `<name>-values.yaml` file is needed in `<chart name>/ci`. This is also a requirement for chart linting. These values are used to install the chart inside the cluster.
The tests themselves are Kubernetes resources and are placed in `<chart name>/templates/tests`, they follow the Helm templating system and have access to all values. The tests are run inside a Pod resource and it will be checked for exit status. This pod will run in the same environment where the chart is deployed.
Inside the Pod it is adviced to run a test framework like [bats](https://github.com/bats-core/bats-core) to test the behaviour of the deployed services. The used test framework and image is not a given, in certain situations using the same image as the deployment may be useful where as others another might be handy.

It is important to keep in mind that the tests run inside Travis CI where resources and run time are limited.

## Local testing
Tests can be run on Kubernetes cluster manually by using `helm test <release name>`. This can only be done after a `helm install` of the chart.
It is important to keep in mind that any changes to the tests need to be deployed using Helm before they can be run in `helm test`.

## The setup
To test changed charts we use Travis CI which runs in 2 stages. The first is Linting, this step runs `ct lint` with the [chart-testing tool](https://github.com/helm/chart-testing) on all charts (change detection is currently not active due to the structure of our repository). Linting will test the validity towards the Helm spec as well as the YAML style.
In stage `Tests` we boot a Kubernetes cluster inside Travis CI using Minikube and Docker. After the cluster and the Helm tiller are intitialized, the chart-testing tool will install all changed charts and then run the tests inside a newly generated namespace in this cluster.
