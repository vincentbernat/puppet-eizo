define eizo::interface::ifup(
  $description = "",
  $order = 99,
  $static = undef,
  $gateway = undef,
  $vlan = undef,
  $also = {}) {

  $interfaces = lookup('eizo::interfaces',{merge=>hash})
  file { "/etc/network/interfaces.d/${order}-${name}":
    content => template("eizo/interfaces/ifup.erb")
  }
}
