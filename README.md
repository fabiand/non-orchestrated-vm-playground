# Run non orchestrated or standalone VMs

Non-orchestrated VMs could be VMs which are not managed by KubeVirt controllers,
instead they are directly consumed by pods.

If only a pod is required to launch a VM, then VMs can be used with everything
which is launching pods. I.e. Deployments, ReplicaSets, …
On the other hand this has drawbacks as the feature set is limited.

```bash
# Deploy some dependencies
$ kubectl apply -f manifests/deps.yaml

# Define the VM definition
$ kubectl apply -f manifests/vm.yaml


# Launch a pod using the defined VM definition
$ kubectl apply -f manifests/pod.yaml

# To watch it boot
$ kubectl logs -f testvm

# To access it
$ kubectl attach -it testvm

# To access it's display
$ kubectl port-forward 5942
$ remote-viewer spice://127.0.0.1:5942


# Launch a deployment using the VM definition
$ kubectl apply -f manifests/deployment.yaml
```
