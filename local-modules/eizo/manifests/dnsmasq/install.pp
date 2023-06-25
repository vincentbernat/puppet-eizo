class eizo::dnsmasq::install inherits eizo::dnsmasq {

  package { 'unbound': ensure => present}
  package { 'resolvconf': ensure => purged }
  package { 'dnsmasq': ensure => present}
  ->
  file { '/var/lib/dnsmasq':
    ensure => "directory",
    owner => "dnsmasq"
  }

}
