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
$ xsltproc domxml2qemu.xslt generic.xml
```
