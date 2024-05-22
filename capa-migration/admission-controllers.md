# Admission Controllers

There are several admission controllers one can additionally enable in Kubernetes. In the past, this was achieved by using our `k8s-initiator-app` to manipulate the Kubernetes API Server manifests on control plane nodes.

With Cluster API, we are starting to offer a more type-safe way of enabling and configuring additional admission controllers. As the so called [`PodNodeSelector`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector) admission controller has often been used by customers in the past, this document will explain how to enable and configure an additional admission controller based on that example.

As of now, the [`cluster`](https://github.com/giantswarm/cluster) chart comes with two values responsible for setting up admission controllers and their configuration:

- `internal.advancedConfiguration.controlPlane.apiServer.additionalAdmissionPlugins`
- `internal.advancedConfiguration.controlPlane.apiServer.admissionConfiguration`

Additional information about their schema can be found in the [`README.md`](https://github.com/giantswarm/cluster/blob/main/helm/cluster/README.md).

Imagine you were using the [`PodNodeSelector`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector) without any further configuration like a `clusterDefaultNodeSelector` before. To have this admission controller enabled and setup in your new Cluster API cluster, you just need to prepare the following migration configuration, which then gets picked up by the [`capi-migration-cli`](https://github.com/giantswarm/capi-migration-cli):

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
              additionalAdmissionPlugins:
              - PodNodeSelector
```

This way the [`PodNodeSelector`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector) admission controller gets enabled on your new control plane nodes. If you additionally want to configure the way the admission controller works, you can setup the migration configuration as follows:

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
              additionalAdmissionPlugins:
              - PodNodeSelector
              admissionConfiguration:
                plugins:
                - name: PodNodeSelector
                  config: |
                    podNodeSelectorPluginConfig:
                      clusterDefaultNodeSelector: giantswarm.io/machine-pool={cluster_name}-{machine_pool_name}
```

If you already used the `clusterDefaultNodeSelector` before, the `k8s-initiator-app` already setup the `kube-system` and `giantswarm` namespaces to ignore that. On new clusters, you will need to manually add the according annotations to ignore the `clusterDefaultNodeSelector`:

```bash
kubectl annotate namespaces kube-system giantswarm scheduler.alpha.kubernetes.io/node-selector=
```

The empty value makes the [`PodNodeSelector`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector) admission controller not fallback to the `clusterDefaultNodeSelector` while still not limiting pods to any nodes.
