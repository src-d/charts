{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "sourced-ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sourced-ui.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "sourced-ui.admin.secretName" -}}
{{- printf "admin-%s" (include "sourced-ui.fullname" .) -}}
{{- end -}}

{{- define "sourced-ui.admin.hookSecretName" -}}
{{- printf "hook-admin-%s" (include "sourced-ui.fullname" .) -}}
{{- end -}}

{{- define "sourced-ui.postgres.secretName" -}}
{{- printf "postgres-%s" (include "sourced-ui.fullname" .) -}}
{{- end -}}

{{- define "sourced-ui.postgres.hookSecretName" -}}
{{- printf "hook-postgres-%s" (include "sourced-ui.fullname" .) -}}
{{- end -}}

{{- define "sourced-ui.gitbase.secretName" -}}
{{- printf "gitbase-%s" (include "sourced-ui.fullname" .) -}}
{{- end -}}

{{- define "sourced-ui.gitbase.hookSecretName" -}}
{{- printf "hook-gitbase-%s" (include "sourced-ui.fullname" .) -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sourced-ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
