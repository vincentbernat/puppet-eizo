class eizo::hostapd::install inherits eizo::hostapd {

  package { 'hostapd':
    ensure => present
  }

}
