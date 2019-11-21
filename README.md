# k8s-initiator-app

An application that runs as daemonset only in the master nodes to maintain the state of some Kubernetes resources through cluster upgrades or master replacements.

As an example to persist a Pod Security Policy you can provide this values configuration at installation time

```yaml
files:
- |
  apiVersion: extensions/v1beta1
  kind: PodSecurityPolicy
  metadata:
    name: restricted
  spec:
    allowPrivilegeEscalation: true
    fsGroup:
      rule: RunAsAny
    runAsUser:
      rule: RunAsAny
    seLinux:
      rule: RunAsAny
    supplementalGroups:
      rule: RunAsAny
    volumes:
    - emptyDir
    - secret
    - downwardAPI
    - configMap
    - persistentVolumeClaim
    - projected
```

It will create or overwrite the pod security policy `restricted` even if cluster is upgraded.
