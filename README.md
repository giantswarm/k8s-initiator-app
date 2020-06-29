# k8s-initiator-app

An application that runs as daemonset only in the master nodes (by default) to maintain the state of some Kubernetes resources through cluster upgrades or master replacements.

As an example to persist a Pod Security Policy you can provide this values configuration at installation time it will create or overwrite the pod security policy `restricted` even if cluster is upgraded:

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


This will set the OIDC settings of a cluster. If available please use the CR to set OIDC, only use this as a last resource.
```yaml
command:
  - sh
  - -c
  - |
    APIMANIFEST=/manifests/k8s-api-server.yaml
    ISSUERURL=https://test.com
    CLIENTID=123123
    CLAIM=email
    if ! grep -q oidc-client-id $APIMANIFEST; then
      echo "OIDC Settings not present, applying"
      echo "Previous API yaml"
      cat $APIMANIFEST
      awk '/feature-gates/ { print; print "    - --oidc-issuer-url=$ISSUERURL\n    - --oidc-client-id=$CLIENTID\n    - --oidc-username-claim=$CLAIM"; next }1' $APIMANIFEST > /tmp/tmp_api.yaml
      mv /tmp/tmp_api.yaml $APIMANIFEST
      echo "New api yaml:"
      cat $APIMANIFEST
    else
      echo "OIDC Settings present"
    fi
```
