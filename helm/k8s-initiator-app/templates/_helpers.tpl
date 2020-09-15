{{- define "initiator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "initiator.fullname" -}}
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

{{- define "initiator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "initiator.nodeSelector" -}}
{{- if .Values.masterOnly -}}
tolerations:
- effect: NoSchedule
  operator: "Exists"
  key: node-role.kubernetes.io/master
nodeSelector:
  kubernetes.io/role: master
{{- else if .Values.nodeSelector }}
nodeSelector:
{{ toYaml .Values.nodeSelector | indent 2 }}
{{- end -}}
{{- end -}}

{{- define "initiator.affinity" -}}
affinity:
{{ toYaml .Values.affinity | indent 2 }}
{{- end -}}

{{- define "initiator.extraVolumes" -}}
{{- range .Values.extraHostPaths }}
- name: {{ .name }}
  hostPath:
    path: {{ .hostPath }}
{{- end }}
{{- end -}}

{{- define "initiator.extraVolumeMounts" -}}
{{- range .Values.extraHostPaths }}
- name: {{ .name }}
  mountPath: {{ .mountPath }}
{{- end }}
{{- end -}}


