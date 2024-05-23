# Container Logs

Kubelet offers a whole range of customization options. Two among them are `containerLogMaxSize` and `containerLogMaxFiles`. Using them, one can define how big a container log file may grow before it's getting rotated and how many of those files are getting retained. By default, Kubelet rotates container log files at [`10Mi`](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1#:~:text=containerLogMaxSize) and keeps [5 files](https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1#:~:text=containerLogMaxFiles) in total.

If for some reason this behavior needs to be changed from the default, one could use the `k8s-initiator-app` to manipulate the Kubelet configuration of a node in the past. With Cluster API, this is no longer a supported way. We therefore implemented the following two properites in the [`cluster`](https://github.com/giantswarm/cluster) chart:

- `internal.advancedConfiguration.kubelet.containerLogMaxSize`
- `internal.advancedConfiguration.kubelet.containerLogMaxFiles`

Additional information about their schema can be found in the [`README.md`](https://github.com/giantswarm/cluster/blob/main/helm/cluster/README.md).

To make our [`capi-migration-cli`](https://github.com/giantswarm/capi-migration-cli) configure your new Cluster API cluster properly, you can put the desired values into the migration configuration as follows:

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
          kubelet:
            containerLogMaxSize: 100Mi
            containerLogMaxFiles: 10
```

This way the Kubelet gets configured to rotate container log files at `100Mi` and retain 10 files in total.
