# == Class: eizo::interface::vlan
#
# Configure a VLAN interface under a given name
#
# === Parameters
#
# [*name*]
#  Name we want to remove the network interface to. Renaming is
#  mandatory. We want pretty names.
#
# [*id*]
#  VLAN ID
#
# [*description*]
#  A description for the usage of this interface
#
define eizo::interface::physical($id, $description) {

  file { "/etc/systemd/network/$name.netdev":
    ensure => present,
    content => template("eizo/interfaces/vlan.erb")
  }

}
