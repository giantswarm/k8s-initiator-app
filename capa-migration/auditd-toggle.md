# Auditd kernel settings

In Vintage product the `auditd` kernel setting is enabled by default. Auditd kernel subsystem is using deprecated flags in Linux kernel 6, heavily impacting the performance of the kernel itself. 
As Vintage v20 as well as CAPA are bringing latest Flatcar with kernel 6, it can cause issues for workloads such as Jenkins, impacting the nodes performance.

In CAPA by design the `auditd` setting will always be disabled and can be toggled back with Cluster values `global.components.auditd.enabled`.

As some customers are creating a workaround with `k8s-initiator-app`, we would like to also include this in the migration procedure in order to facilitate any setting that has been configured on Vintage.

Below you can find a snippet of the configuration which will allow customers to control this setting (i.e. turn auditd back on) before migrating to CAPA via `migration-configuration-{cluster_name}.yaml` configmap:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: {cluster_name}-migration-configuration
  namespace: {cluster_namespace}
data: 
  values: |
    global:
      components:
        auditd:
          enabled: true
```
