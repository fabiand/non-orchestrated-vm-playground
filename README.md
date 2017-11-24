[![Build Status](https://travis-ci.org/fabiand/xslt-domxml-to-native-qemu-argv.svg?branch=e2e)](https://travis-ci.org/fabiand/xslt-domxml-to-native-qemu-argv)

# Building qemu commandline from a libvirt domxml

Libvrti's domxml are neat to define a VM, however, sometimes you might just
want to run it in a different context.
In that case it's lame to re-write the qemu commandline manualy, based on a
domxml.

This little XSLT stylesheet does this translatoin for you.

but take care, libvirt does much more, and this style shet is limited to the
"most important" parts of a domxml in order to get a VM up and running.

Usage:

```bash
$ eval "$(xsltproc domxml2qemu.xslt fedora27.xml)" &
$ remote-viewer spice://127.0.0.1:5942

$ xsltproc domxml2qemu.xslt fedora27.xml
/usr/bin/qemu-kvm \
  -name fedora27 \
  -uuid 5a47680f-6776-4fb5-b586-463663c71747 \
  -m 8096 \
  -smp 4 \
  -machine pc-i440fx-2.3,accel=kvm \
  \
-cpu host \
  \
  -netdev user,id=hostnet1 \
  -device rtl8139,netdev=hostnet1,id=net1,mac=52:54:00:bc:23:86 \
 \
  \
  -device qxl,id=video1,ram_size=67108864,vram_size=67108864,vgamem_mb=16 \
 \
  \
-spice port=5942,addr=127.0.0.1,disable-ticketing,image-compression=off,seamless-migration=on \
 \
  \
  -drive file=https://download.fedoraproject.org/pub/fedora/linux/releases/27/Workstation/x86_64/iso/Fedora-Workstation-Live-x86_64-27-1.6.iso,format=raw,if=virtio,id=drive1\
,readonly=on \
 \
  # End
```
