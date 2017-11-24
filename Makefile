
domxml2qemu:
	xsltproc domxml2qemu.xslt data/fedora27.xml

data/vm.yaml.xml: data/vm.yaml
	./yaml2xml $< > $@

vmspec2domxml: data/vm.yaml.xml
	xsltproc vmspec2domxml.xslt data/vm.yaml.xml

build:
	sudo docker build -t docker.io/fabiand/lvm .

push:
	sudo docker push docker.io/fabiand/lvm
