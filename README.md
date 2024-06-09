Configuring "eizo" with puppet
==============================

*eizo* is a machine acting as a NAS, media player and router. The
 configuration is maintained by Puppet.

It is quite unlikely to do anything right for you. This configuration
doesn't pretend to apply to any other host than *eizo*.

This requires [Debian Bookworm][] and the following packages to be
installed:

 - `puppet`
 - `librarian-puppet`
 - `libaugeas-ruby`
 - `systemd-sysv` (and a reboot would be welcome)

The interface configuration part is tricky. The easiest way to get it
going is to remove `/etc/udev/rules.d/70-persistent-net.rules` and
reboot since it needs a modification of kernel parameters to work.

To run, use:

    librarian-puppet install
    ./run

[Debian Bookworm]: https://www.debian.org/releases/bookworm/

Before a major change:

```
lvcreate --size 20G --snapshot --name root-snap /dev/eizo-vg/root
```

Then, later, either discard the snapshot:

```
lvremove /dev/eizo-vg/root-snap
```

Or restore it:

```
lvconvert --merge /dev/eizo-vg/root-snap
```
