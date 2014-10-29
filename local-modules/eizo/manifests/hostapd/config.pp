class eizo::hostapd::config inherits eizo::hostapd {

  file { '/etc/hostapd/hostapd.conf':
    ensure => present,
    content => template("eizo/hostapd/hostapd.conf.erb")
  }

}
