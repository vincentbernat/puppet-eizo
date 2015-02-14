class eizo::miniupnpd::install inherits eizo::miniupnpd {

  package { 'miniupnpd':
    ensure => present
  }

}
