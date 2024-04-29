{{/*
Expand the name of the chart.
*/}}
{{- define "flags.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "flags.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "flags.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "flags.labels" -}}
helm.sh/chart: {{ include "flags.chart" . }}
{{ include "flags.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "flags.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flags.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "flags.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "flags.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "flags.targeting" -}}
{{- $targeting := index . 0 -}}
{{- $defaultValue := index . 1 -}}
targeting:
  if:
    {{- include "flags.targetingRules" (list $targeting $defaultValue) | nindent 4 -}}
{{- end }}

{{- define "flags.targetingRuleCondition" -}}
{{- $targetingRule := index . 0 -}}
in:
  - var: {{ $targetingRule.contextKey | quote }}
  - {{ $targetingRule.contextValues | toYaml | nindent 4 }}
{{- end }}

{{- define "flags.targetingRuleIfStatement" -}}
{{- $targetingRule := index . 0 }}
{{- $defaultValue := index . 1 }}
{{- if $defaultValue -}}
- {{ $defaultValue | quote }}
{{- else }}
- {{- include "flags.targetingRuleCondition" (list $targetingRule) | nindent 2 -}}
- {{ $targetingRule.variantName }}
{{- end }}
{{- end }}

{{- define "flags.targetingRules" -}}
{{- $targetingRules := index . 0 }}
{{- $defaultValue := index . 1 }}
{{- $rule := index $targetingRules 0 }}
{{- $sliceLength := (sub (len $targetingRules) 1) -}}
{{- if $rule.in }}
- in:
    - var: {{ $rule.var | quote }}
    - {{ $rule.in | toJson }}
{{- else if $rule.sem_ver }}
- sem_ver:
    - var: {{ $rule.var | quote }}
    - {{ $rule.sem_ver.op | quote }}
    - {{ $rule.sem_ver.version | quote }}
{{- end }}
- {{ $rule.variantName | quote }}
{{- if gt $sliceLength 0 }}
- if:
    {{- include "flags.targetingRules" (list (slice $targetingRules 1) $defaultValue) | nindent 4 }}
{{- else }}
- {{ $defaultValue | quote }}
{{- end }}
{{- end }}