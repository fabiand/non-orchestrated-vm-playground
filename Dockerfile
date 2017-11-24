FROM kubevirt/libvirt

RUN dnf install -y libxslt python3-xmltodict python3-PyYAML
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl && chmod a+x /usr/bin/kubectl


ADD yaml2xml /
ADD vmspec2domxml.xslt /
ADD domxml2qemu.xslt /
ADD launch-VirtualMachine /
RUN ln -s launch-VirtualMachine launch

ADD data/vm.yaml /

CMD /launch-VirtualMachine
