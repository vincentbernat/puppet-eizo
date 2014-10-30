class eizo::dnsmasq::config inherits eizo::dnsmasq {

  $dhcp = hiera_hash(hiera("eizo::dnsmasq::dhcp"))
  file { '/etc/dnsmasq.conf':
    ensure => present,
    content => template("eizo/dnsmasq/dnsmasq.conf.erb")
  }
  ->
  file { '/etc/dhcp/dhclient-enter-hooks.d/dnsmasq-resolvconf':
    source => "puppet:///modules/eizo/dnsmasq/dnsmasq-resolvconf"
  }
  ->
  file { '/etc/resolv.conf':
    content => "search home\nnameserver 127.0.0.1\n"
  }

}
