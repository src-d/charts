{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bblfshd-sidecar.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bblfshd-sidecar.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
These parts are needed to instert bblfsh
*/}}

{{- define "bblfshd-sidecar.volumes" -}}
- name: install-bblfshd-drivers-volume
  configMap:
    name: {{.Release.Name}}-bblfshd-sidecar-install-drivers
    items:
    - key: install-bblfshd-drivers.sh
      path: install-bblfshd-drivers.sh
{{- end -}}

{{- define "bblfshd-sidecar.containers" -}}
- name: bblfshd
  image: "{{index .Values "bblfshd-sidecar" "image" "repository" }}:{{index .Values "bblfshd-sidecar" "image" "tag" }}"
  imagePullPolicy: {{index .Values "bblfshd-sidecar" "image" "pullPolicy" }}
  volumeMounts:
    - name: install-bblfshd-drivers-volume
      mountPath: /opt/install-bblfshd-drivers.sh
      subPath: install-bblfshd-drivers.sh
  lifecycle:
    postStart:
      exec:
        command: [ "sh", "/opt/install-bblfshd-drivers.sh" ]
  livenessProbe:
    tcpSocket:
      port: 9432
  readinessProbe:
    tcpSocket:
      port: 9432
  securityContext:
    privileged: true
{{- end -}}
