# Node Taints and Labels migration from k8s-initiator-app

One of the key features to pay attention to during migration is to support the `k8s-initiator-app` feature of `node-tainting` and `node-labeling`.

Node tainting and labeling is directly available in CAPA and can be configured accordingly. 

We recognized that customers do use `giantswarm.io/machine-deployment` label to schedule the workloads on given Node Pools. 
As CAPA uses the concept of `Machine Pool`, the label is changed to `giantswarm.io/machine-pool`. 

In order to not break customer scheduling preferences, we will adjust the migration tool to also keep the `machine-deployment` label for initial consistency. This way customers will be able to adjust their deployments accordingly after the migration.

As `k8s-initiator-app` enables customers to work with custom bash scripts, we have to standardize the `node-tainting` on Vintage clusters such that the settings can be easily migrated and applied on newly created CAPA clusters. 
For this purpose we would ask AEs to work together with customers to create a `configmap` per cluster in cluster namespace called `migration-configuration-{cluster_name}.yaml` with a following structure that follows the CAPA semantics for cluster configuration.

Below you can find an exampe of the configmap that will be picked up by the migration tooling: 

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {cluster_name}-migration-configuration
  namespace: {cluster_namespace}
data: 
  values: |
    global:
      nodePools:
        {node_pool_name}:
          customNodeLabels:
          - node-custom-label={custom_node_label}
          customNodeTaints:
          - effect: {effect - e.g. NoSchedule}
            key: {key}
            value: {value}
            operator: {operator - e.g. Equal}
```
