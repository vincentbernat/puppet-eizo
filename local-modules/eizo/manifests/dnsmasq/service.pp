class eizo::dnsmasq::service inherits eizo::dnsmasq {

  service { 'dnsmasq':
    ensure => running,
    enable => true
  }

}
