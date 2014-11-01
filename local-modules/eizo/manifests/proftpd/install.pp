class eizo::proftpd::install inherits eizo::proftpd {

  package { 'proftpd':
    ensure => present
  }

}
