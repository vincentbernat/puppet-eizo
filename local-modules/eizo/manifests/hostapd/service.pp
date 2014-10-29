class eizo::hostapd::service inherits eizo::hostapd {

  service { 'hostapd':
    ensure => running,
    enable => true
  }

}
