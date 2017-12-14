# Run non-orchestrated (or standalone) VMs

Non-orchestrated VMs could be VMs which are not managed by KubeVirt controllers,
instead they are directly consumed by pods.

If only a pod is required to launch a VM, then VMs can be used with everything
which is launching pods. I.e. Deployments, ReplicaSets, …
On the other hand this has drawbacks as the feature set is limited.

## How it works

The pod is responsible for launching the VM, so it does everything itself.
The logic required to do this is shipped in the launch container.

In general it works as follows:

- Guess the VM definition to use
- Pull down the VM definition
- [Create the VM](launch.d/) based on this definition

## Entities

The following example is generally using [this VM definition](manifests/vm.yaml)
and [this pod definition](manifests/pod.yaml).
In general it's worth to take a look into the [`manifests/`](manifests/) dir.

## Example

You will need `minikube` or a different Kubernetes cluster.

The next step is to clone the repository (not required, but then you can cut
and paste the steps below).

```bash
$ git clone https://github.com/fabiand/non-orchestrated-vm-playground/
$ cd non-orchestrated-vm-playground
```

Now we can start to setup the cluster:

```bash
# Deploy some dependencies
$ kubectl apply -f manifests/deps.yaml

# Define the VM definition
$ kubectl apply -f manifests/vm.yaml


# Launch a pod using the defined VM definition
$ kubectl apply -f manifests/pod.yaml

# To watch it boot
$ kubectl logs -f testvm

# To access the serial
$ kubectl exec -it testvm /vm/serial

# To access the monitor
$ kubectl exec -it testvm /vm/monitor
$ kubectl exec -it testvm /vm/qmp

# To access it's vnc display
$ socat SYSTEM:"kubectl exec -i testvm /vm/vnc" tcp-listen:5942
$ remote-viewer vnc://127.0.0.1:5942
```

### Higher level workload types

This approach also works for higher level workloads:

```bash
# Launch a deployment using the VM definition
$ kubectl apply -f manifests/deployment.yaml

# See the spawned pods
$ kubectl get pods
```

## Known Issues

- Alpine does not bring up networking by default
- Exposing ports is [not done yet](https://github.com/fabiand/pod-network-poc)
- No checks about if the VM fits into the pod

## Charming next steps

- `ServiceAccount`
- Policies for `hostNetwork` in order to use PVs
