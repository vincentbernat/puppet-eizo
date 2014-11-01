class eizo::dnsmasq::install inherits eizo::dnsmasq {

  package { 'dnsmasq':
    ensure => present
  }
  ->
  file { '/var/lib/dnsmasq':
    ensure => "directory",
    owner => "dnsmasq"
  }

}
