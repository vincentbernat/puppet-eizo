class eizo::transmission::service inherits eizo::transmission {

  service { 'transmission-daemon':
    ensure => running,
    enable => true
  }

}
