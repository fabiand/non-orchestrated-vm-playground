FROM fedora:26

RUN dnf install -y qemu-kvm qemu-system-x86 libxslt python3-xmltodict python3-PyYAML kubernetes-client

ADD yaml2xml /
ADD vmspec2domxml.xslt /
ADD domxml2qemu.xslt /
ADD launch-VirtualMachine /

ADD vm.yaml /

CMD /launch-VirtualMachine /launch
