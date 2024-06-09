class eizo::dnsmasq::service inherits eizo::dnsmasq {

  service { 'unbound':
    ensure => running,
    enable => true
  }
  ->
  service { 'dnsmasq':
    ensure => running,
    enable => true
  }

}
