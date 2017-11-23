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
$ xsltproc domxml2qemu.xslt fedora24.xml
/usr/bin/qemu-kvm \
  -name fedora24 \
  -uuid 1edb7a80-6beb-4c4e-b2f3-0ebb9647edea \
  -m 8096 \
  -smp 4 \
  -machine pc-i440fx-2.3,accel=kvm \
  \
-cpu host \
  \
  -netdev user,id=hostnet1 \
  -device rtl8139,netdev=hostnet1,id=net1,mac=52:54:00:4f:b5:e0 \
\
  -netdev user,id=hostnet2 \
  -device rtl8139,netdev=hostnet2,id=net2,mac=52:54:00:bc:23:86 \
 \
  \
  -device qxl,id=video1,ram_size=67108864,vram_size=67108864,vgamem_mb=16 \
 \
  \
-spice port=5900,addr=127.0.0.1,disable-ticketing,image-compression=off,seamless-migration=on \
 \
  \
  -drive file=/home/foobar/.local/share/libvirt/images/fedora24.qcow2,format=qcow2,if=virtio,id=drive1 \
\
  -drive file=/home/foobar/.local/share/libvirt/images/fedora24-1.qcow2,format=qcow2,if=virtio,id=drive2 \
 \
  # End
```
