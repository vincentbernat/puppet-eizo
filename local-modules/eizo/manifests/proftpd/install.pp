class eizo::proftpd::install inherits eizo::proftpd {

  package { 'proftpd-basic':
    ensure => present
  }

}
