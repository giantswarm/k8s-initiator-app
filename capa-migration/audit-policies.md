# Audit Policies

The Kubernetes API server offers an extensible way of configuring [audit policies](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/#audit-policy) for different kind of resources and requests. While Giant Swarm clusters already come with a comprehensive set of [default rules](https://github.com/giantswarm/cluster/blob/main/helm/cluster/files/etc/kubernetes/policies/audit-policy.yaml), they still can be extended by your own list of policies.

In the past you might have done this using our `k8s-initiator-app`. As this app will no longer be supported with Cluster API, you will need to provide your custom audit policies in a different way. Therefore we implemented the following property in our [`cluster`](https://github.com/giantswarm/cluster) chart:

- `internal.advancedConfiguration.controlPlane.apiServer.auditPolicy.extraRules`

Additional information about its schema can be found in the [`README.md`](https://github.com/giantswarm/cluster/blob/main/helm/cluster/README.md).

Fortunately the [`capi-migration-cli`](https://github.com/giantswarm/capi-migration-cli) is capable of migrating your custom rules into your new cluster. The only thing you need to do is providing them in a migration configuration as follows:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {cluster_name}-migration-configuration
  namespace: {cluster_namespace}
data: 
  values: |
    cluster:
      internal:
        advancedConfiguration:
          controlPlane:
            apiServer:
              auditPolicy:
                extraRules:
                - users:
                  - system:unsecured
                  verbs:
                  - get
                  resources:
                  - group: ""
                    resources:
                    - configmaps
                  namespaces:
                  - kube-system
                  level: Request
```

The Kubernetes API server processes them in order of appearance and uses the first matching rule for logging the requested information. Since your extra rules will be added on top of our [default rules](https://github.com/giantswarm/cluster/blob/main/helm/cluster/files/etc/kubernetes/policies/audit-policy.yaml), they will therefore take precedence over them.
