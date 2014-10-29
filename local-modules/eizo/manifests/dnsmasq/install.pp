class eizo::dnsmasq::install inherits eizo::dnsmasq {

  package { 'dnsmasq':
    ensure => present
  }

}
