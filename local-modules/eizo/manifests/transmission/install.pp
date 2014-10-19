class eizo::transmission::install inherits eizo::transmission {

  package { 'transmission-daemon':
    ensure => present
  }
  ->
  file { "${download}":
    ensure => directory,
    owner => "debian-transmission"
  }
  ->
  file { "${download}/incomplete":
    ensure => directory,
    owner => "debian-transmission"
  }
  ->
  file { "${download}/complete":
    ensure => directory,
    owner => "debian-transmission"
  }
  ->
  file { "${download}/watch":
    ensure => directory,
    owner => "debian-transmission"
  }

}
