class eizo::dnsmasq::service inherits eizo::dnsmasq {

  service { 'unbound':
    provider => "debian",
    ensure => running,
    enable => true
  }
  ->
  service { 'dnsmasq':
    ensure => running,
    enable => true
  }

}
