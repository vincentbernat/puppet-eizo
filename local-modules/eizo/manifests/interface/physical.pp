# == Class: eizo::interface::physical
#
# Configure a physical interface under a given name and with any
# number of named VLAN. We chose to use the path to identify a
# card. As there is very little cards in our setup (3?), we could have
# just used something like the model.
#
# === Parameters
#
# [*name*]
#  Name we want to remove the network interface to. Renaming is
#  mandatory. We want pretty names.
#
# [*path*]
#  Path, as seen by udev in ID_PATH (udevadm info
#  /sys/class/net/eth0)
#
# [*description*]
#  A description for the usage of this interface
#
# [*vlans*]
#  Associated VLAN. It is map from names to eizo::interface::vlan
#  stuff
#
define eizo::interface::physical($path, $description, $vlans = {}) {

  file { "/etc/systemd/network/$name.link":
    ensure => present,
    content => template("eizo/interfaces/physical.erb")
  }
  file { "/etc/systemd/network/$name.network":
    ensure => present,
    content => template("eizo/interfaces/physical-network.erb")
  }
  create_resources(
    'eizo::interface::vlan',
    $vlans,
    { notify => Exec["reload systemd for network interfaces"] })

}
