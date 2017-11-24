The launcher works pretty simple

1. Fetch spec in yaml from cluster using `kubectl`
2. Translate _spec yaml_ to _spec xml_
3. Transform _spec xml_ to _domxml_ (usually done by `virt-handler`)
4. Transform _domxml_ to _qemu cmdline_ (usually done by `libvirt`)
5. Launch qemu
