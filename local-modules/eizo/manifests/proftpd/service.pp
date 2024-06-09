class eizo::proftpd::service inherits eizo::proftpd {

  service { 'proftpd':
    ensure => running,
    enable => true
  }

}
