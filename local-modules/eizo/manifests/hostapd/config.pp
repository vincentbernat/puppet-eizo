class eizo::hostapd::config inherits eizo::hostapd {

  file { '/etc/hostapd/hostapd.conf':
    ensure => present,
    content => template("eizo/hostapd/hostapd.conf.erb"),
    mode => "go=",
    owner => "root"
  }

  shellvar { 'DAEMON_CONF':
    ensure => present,
    target => '/etc/default/hostapd',
    value  => '/etc/hostapd/hostapd.conf',
  }

}
