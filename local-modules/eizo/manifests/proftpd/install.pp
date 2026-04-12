class eizo::proftpd::install inherits eizo::proftpd {

  package { 'proftpd-core':
    ensure => present
  }

}
