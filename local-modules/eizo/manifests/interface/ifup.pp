define eizo::interface::ifup($conf) {

  file { "/etc/network/interfaces.d/${conf[order]}-${name}":
    content => template("eizo/interfaces/ifup.erb")
  }

  if ($conf[path]) {
    udev::rule { "60-ifup-${name}":
      content => template("eizo/interfaces/udev.erb")
    }
  }

  if ($conf[dhcp]) {
    concat::fragment { "dhcp-${name}.conf":
      target => "/etc/dhcp/dhclient.conf",
      content => template("eizo/interfaces/dhclient.conf.erb")
    }
  }

}
