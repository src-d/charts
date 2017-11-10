# Kube cert manager

This chart deploys [kube-cert-manager](https://github.com/PalmStoneGames/kube-cert-manager)

## Pre-requisites

- Kubernetes 1.7+
- kube-cert-manager 0.5.0+

## Scope

This is intended to use Google DNS for Let's Encrypt challenges. `kube-cert-manager` supports more challenges, but we're currently only interested in those.

## Installing the Chart

To install the chart with the release name `kcm` using the key from a Google Service Account with `DNSAdmin` role in the file `google-key.json`:

```bash
helm install -n kcm . --set \
google.base64JsonKey="$(cat google-key.json | base64)",\
google.project=srcd-production
```

## Configuration

See `values.yaml` for the available configuration parameters.
