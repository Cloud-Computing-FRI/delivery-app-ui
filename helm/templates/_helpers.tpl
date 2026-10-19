{{/*
Template helpers for the UI chart.
*/}}

{{- define "ui.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ui.fullname" -}}
{{- default (include "ui.name" .) .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ui.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Common labels. Call with the root context ($). */}}
{{- define "ui.labels" -}}
helm.sh/chart: {{ include "ui.chart" . }}
app.kubernetes.io/part-of: delivery-app
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Selector labels. Call with the root context ($). */}}
{{- define "ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: ui
{{- end -}}

{{/*
The nginx config. Serves the page and forwards /api/... to the backend
services, so the browser only ever talks to this one address. Upstream hosts
come from .Values.backends. Defined as a template so the Deployment can both
mount it and checksum it (rolling the pod when routing changes).
*/}}
{{- define "ui.nginxConf" -}}
server {
    listen 80;
    root /usr/share/nginx/html;
    index index.html;

    location /api/restaurants {
        proxy_pass {{ .Values.backends.restaurants }}/restaurants;
    }
    location /api/orders {
        proxy_pass {{ .Values.backends.orders }}/orders;
    }
    location /api/notifications {
        proxy_pass {{ .Values.backends.notifications }}/notifications;
    }
}
{{- end -}}
