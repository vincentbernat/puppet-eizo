Configuring "eizo" with puppet
==============================

*eizo* is a machine acting as a NAS, media player and router. The
 configuration is maintained by Puppet.

It is quite unlikely to do anything right for you. This configuration
doesn't pretend to apply to any other host than *eizo*.

This requires [Debian Jessie][] and the following packages to be
installed:

 - `ruby`
 - `bundler`
 - `systemd-sysv` (and a reboot would be welcome)

[Debian Jessie]: https://www.debian.org/releases/jessie/
