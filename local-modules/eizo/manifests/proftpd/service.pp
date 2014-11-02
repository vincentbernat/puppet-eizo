class eizo::proftpd::service inherits eizo::proftpd {

  service { 'proftpd':
    provider => "debian",
    ensure => running,
    enable => true
  }

}
