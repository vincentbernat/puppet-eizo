class eizo::transmission::install inherits eizo::transmission {

  File {
    owner => "debian-transmission",
    group => "nas",
    mode => "g+ws",
    require => Group['nas']
  }
  package { 'transmission-daemon':
    ensure => present
  }
  ->
  file { "${download}":
    ensure => directory,
  }
  ->
  file { "${download}/incomplete":
    ensure => directory,
  }
  ->
  file { "${download}/complete":
    ensure => directory,
  }
  ->
  file { "${download}/watch":
    ensure => directory,
  }

}
