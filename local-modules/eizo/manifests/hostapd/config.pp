class eizo::hostapd::config inherits eizo::hostapd {

  file { '/etc/hostapd/hostapd.conf':
    ensure => present,
    content => template("eizo/hostapd/hostapd.conf.erb")
  }

  shellvar { 'DAEMON_CONF':
    ensure => present,
    target => '/etc/default/hostapd',
    value  => '/etc/hostapd/hostapd.conf',
  }

}
