define eizo::interface::networkd(
  $description = "",
  $order = 99,
  $static = undef,
  $gateway = undef,
  $vlan = undef,
  $online = undef,
  $link = {}) {

  $interfaces = lookup('eizo::interfaces', {merge => hash})

  if ($vlan) {
    file { "/etc/systemd/network/${order}-${name}.netdev":
      content => template("eizo/interfaces/networkd.netdev.erb")
    }
  }

  file { "/etc/systemd/network/${order}-${name}.network":
    content => template("eizo/interfaces/networkd.network.erb")
  }

  if ($link != {}) {
    file { "/etc/systemd/network/${order}-${name}.link":
      content => template("eizo/interfaces/networkd.link.erb")
    }
  }
}
