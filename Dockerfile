FROM kubevirt/libvirt

RUN dnf install -y libxslt python3-xmltodict python3-PyYAML
RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl && chmod a+x /usr/bin/kubectl

CMD /launch

ADD data/applied-vm.yaml /
ADD launch.d/ /launch.d/
ADD launch /

