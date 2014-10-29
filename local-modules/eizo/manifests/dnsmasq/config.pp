class eizo::dnsmasq::config inherits eizo::dnsmasq {

  $dhcp = hiera_hash(hiera("eizo::dnsmasq::dhcp"))
  file { '/etc/dnsmasq.conf':
    ensure => present,
    content => template("eizo/dnsmasq/dnsmasq.conf.erb")
  }

}
