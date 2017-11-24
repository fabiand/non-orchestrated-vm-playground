The launcher works pretty simple

1. Fetch spec in yaml from cluster using `kubectl`
2. Translate _spec yaml_ to _spec xml_ using
   using `python3` (`yaml` and `xmltodict`)
   (usually not required)
3. Transform _spec xml_ to _domxml_
   using [vmspec2domxml.xsl](vmspec2domxml.xsl)
   (usually done by `virt-handler`)
4. Transform _domxml_ to _qemu cmdline_
   using [domxml2qemu.xsl](domxml2qemu.xsl)
   (usually done by `libvirt`)
5. Launch qemu
