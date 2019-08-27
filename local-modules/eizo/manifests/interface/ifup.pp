define eizo::interface::ifup(
  $description = "",
  $path = undef,                # for physical interfaces only
  $order = 99,
  $dhcp = undef,
  $static = undef,
  $vlan = undef,
  $upnp = undef,
  $v6 = false,                  # get an IPv6 prefix from PD
  $also = {}) {

  $interfaces = hiera_hash('eizo::interfaces')
  file { "/etc/network/interfaces.d/${order}-${name}":
    content => template("eizo/interfaces/ifup.erb")
  }

  if ($path) {
    udev::rule { "90-ifup-${name}.rules":
      content => template("eizo/interfaces/udev.erb")
    }
  }

  if ($dhcp) {
    concat::fragment { "dhclient.${name}.conf":
      target => "/etc/dhcp/dhclient.conf",
      content => template("eizo/interfaces/dhclient.conf.erb"),
      order => '10'
    }
  }
}
