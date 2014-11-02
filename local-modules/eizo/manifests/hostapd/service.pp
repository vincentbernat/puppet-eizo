class eizo::hostapd::service inherits eizo::hostapd {

  service { 'hostapd':
    provider => "debian",
    ensure => running,
    enable => true
  }

}
