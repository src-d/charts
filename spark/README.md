# Apache Spark Helm Chart

Apache Spark is a fast and general-purpose cluster computing system

* http://spark.apache.org/

Adapted from https://github.com/kubernetes/charts/tree/master/stable/spark

## Chart Details
This chart will do the following:

* 1 x Spark Master with port 8080 exposed using a ClusterIP service
* A DaemonSet for Spark workers that can be bound to certain nodes using a node selector
* 1 x [Spark Ui Proxy](https://github.com/src-d/spark-ui-proxy) to be able to use Spark web ui behind a firewall or a reverse proxy
* All using Kubernetes Deployments

## Prerequisites

* Assumes that serviceAccount tokens are available under hostname metadata. (Works on GKE by default) URL -- http://metadata/computeMetadata/v1/instance/service-accounts/default/token

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release spark
```

## Configuration

The following tables lists the configurable parameters of the Spark chart and their default values.

### Spark Master

| Parameter               | Description                        | Default                                                    |
| ----------------------- | ---------------------------------- | ---------------------------------------------------------- |
| `Master.Name`           | Spark master name                  | `spark-master`                                             |
| `Master.Image`          | Container image name               | `gcr.io/google_containers/spark`                           |
| `Master.ImageTag`       | Container image tag                | `1.5.1_v3`                                                 |
| `Master.Replicas`       | k8s deployment replicas            | `1`                                                        |
| `Master.Component`      | k8s selector key                   | `spark-master`                                             |
| `Master.Cpu`            | container requested cpu            | `100m`                                                     |
| `Master.Memory`         | container requested memory         | `512Mi`                                                    |
| `Master.ServicePort`    | k8s service port                   | `7077`                                                     |
| `Master.ContainerPort`  | Container listening port           | `7077`                                                     |
| `Master.DaemonMemory`   | Master JVM Xms and Xmx option      | `1g`                                                       |
| `Master.NodeSelector`   | Master k8s node selector           | `{}`

### Spark WebUi

|       Parameter       |           Description            |                         Default                          |
|-----------------------|----------------------------------|----------------------------------------------------------|
| `WebUi.Name`          | Spark webui name                 | `spark-webui`                                            |
| `WebUi.ServicePort`   | k8s service port                 | `8080`                                                   |
| `WebUi.ContainerPort` | Container listening port         | `8080`                                                   |

### Spark WebUiProxy

| Parameter                           | Description                          | Default                                                    |
| ----------------------------------- | ------------------------------------ | ---------------------------------------------------------- |
| `WebUiProxy.Name`                   | Spark ui proxy name                  | `webui-proxy`                                              |
| `WebUiProxy.Image`                  | Container image name                 | `quay.io/srcd/spark-ui-proxy`                              |
| `WebUiProxy.ImageTag`               | Container image tag                  | `1.0`                                                      |
| `WebUiProxy.Replicas`               | k8s deployment replicas              | `1`                                                        |
| `WebUiProxy.Component`              | k8s selector key                     | `spark-ui-proxy`                                           |
| `WebUiProxy.Cpu`                    | container requested cpu              | `100m`                                                     |
| `WebUiProxy.ServicePort`            | k8s service port                     | `80`                                                       |
| `WebUiProxy.ContainerPort`          | Container listening port             | `80`                                                       |
| `WebUiProxy.NodeSelector`           | WebUiProxy k8s node selector         | `{}`                                                       |
| `WebUiProxy.ReverseProxy.Deploy`    | WebUiProxy is behind a reverse proxy | `yes` (we assume it will be kube-proxy)                    |
| `WebUiProxy.ReverseProxy.ApiPrefix` | api-prefix to pass to kube proxy     | `spark-ui-proxy` (we assume it will be kube-proxy)         |
| `WebUiProxy.ReverseProxy.Debug`     | Print debug messages                 | `false` (we assume it will be kube-proxy)                  |

We need the api prefix in order to avoid namespace clashing, as `spark-ui-proxy` rewrites paths under `/api/v1` which is what kube-proxy uses. Hence, in order for this integration to work properly, kube-proxy must be started with `--api-prefix` option

```
$ kubectl proxy --api-prefix=/spark-ui-proxy
```

### Spark Worker

| Parameter                        | Description                          | Default                                                    |
| -------------------------------- | ------------------------------------ | ---------------------------------------------------------- |
| `Worker.Name`                    | Spark worker name                    | `spark-worker`                                             |
| `Worker.Image`                   | Container image name                 | `gcr.io/google_containers/spark`                           |
| `Worker.ImageTag`                | Container image tag                  | `1.5.1_v3`                                                 |
| `Worker.Replicas`                | k8s hpa and deployment replicas      | `3`                                                        |
| `Worker.ReplicasMax`             | k8s hpa max replicas                 | `10`                                                       |
| `Worker.Component`               | k8s selector key                     | `spark-worker`                                             |
| `Worker.Cpu`                     | container requested cpu              | `100m`                                                     |
| `Worker.Memory`                  | container requested memory           | `512Mi`                                                    |
| `Worker.ContainerPort`           | Container listening port             | `7077`                                                     |
| `Worker.CpuTargetPercentage`     | k8s hpa cpu targetPercentage         | `50`                                                       |
| `Worker.DaemonMemory`            | Worker JVM Xms and Xmx setting       | `1g`                                                       |
| `Worker.ExecutorMemory`          | Worker memory available for executor | `1g`                                                       |
| `Worker.NodeSelector`            | Worker k8s node selector             | `{}`                                                       |
| `Worker.AdditionalPodContainers` | Container config to spawn            | `{}`                                                       |
| `Worker.Gluster.endpoint         | Optional Gluster endpoint to mount   |                                                            |
| `Worker.Gluster.volumeName       | Optional Gluster volumeName          |                                                            |
| `Worker.Gluster.mountPath        | Optional Gluster path in container   | `/mnt/glusterfs`                                           |
| `Worker.TemporaryDir`            | Host path for spark tmp dir          | None, it's mandatory                                       |

See [values.yaml](values.yaml) file to get an example of how to pass the `AdditionalPodContainers` configuration

### Loading the chart

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml stable/spark
```

> **Tip**: You can use the default [values.yaml](values.yaml)
