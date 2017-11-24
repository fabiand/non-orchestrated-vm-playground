
domxml2qemu:
	xsltproc launch.d/domxml2qemu.xslt data/fedora27.xml

data/%.yaml.xml: data/%.yaml
	./launch.d/yaml2xml $< > $@

vmspec2domxml: data/vm.yaml.xml
	xsltproc launch.d/vmspec2domxml.xslt $<

build:
	sudo docker build -t docker.io/fabiand/lvm .

push:
	sudo docker push docker.io/fabiand/lvm

run-container:
	sudo docker run --rm -it docker.io/fabiand/lvm launch applied-vm.yaml

run-pod:
	kubectl apply -f manifests/testvm-pod.yaml


deploy-deps:
	kubectl apply -f manifests/iscsi-demo-target.yaml -f manifests/vm-resource.yaml
	kubectl apply -f data/vm.yaml
	./launch.d/kubeObjWait pods

test: deploy-deps run-pod
	timeout 300 sh -c "until kubectl logs --tail=10 testvm | grep Welcome ; do sleep 3 ; echo -n . ; done"
	kubectl delete pods testvm
