# DEPRECATED: k8s-initiator-app
WARNING: This app is deprecated and is not supported in CAPI Giantswarm platform


An application that runs as daemonset only in the nodes (master only by default) to maintain the state of some Kubernetes resources through cluster upgrades or master replacements.

### Examples

- [Audit Policy configuration](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_audit_policy.yaml)
- [ElasticSearch settings](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_elasticsearch.yaml)
- [Enable Admission Controller](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_enable_admission_controller.yaml)
- [Huge pages settings](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_huge_pages.yaml)
- [OIDC parameters](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_oidc.yaml)
- [Add PSP (overwritten default one)](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_psp_restricted.yaml)
- [Add PodTopologySpread scheduler configuration](https://github.com/giantswarm/k8s-initiator-app/blob/master/examples/values_use_a_custom_default_scheduling_topology.yaml)
