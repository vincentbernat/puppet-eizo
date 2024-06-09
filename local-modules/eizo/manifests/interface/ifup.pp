define eizo::interface::ifup(
  $description = "",
  $order = 99,
  $dhcp = undef,
  $static = undef,
  $vlan = undef,
  $v6 = false,                  # get an IPv6 prefix from PD
  $also = {}) {

  $interfaces = lookup('eizo::interfaces',{merge=>hash})
  file { "/etc/network/interfaces.d/${order}-${name}":
    content => template("eizo/interfaces/ifup.erb")
  }

  if ($dhcp) {
    concat::fragment { "dhclient.${name}.conf":
      target => "/etc/dhcp/dhclient.conf",
      content => template("eizo/interfaces/dhclient.conf.erb"),
      order => '10'
    }
  }
}
