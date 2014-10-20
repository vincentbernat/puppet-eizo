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
  user { 'transmission-daemon':
    ensure => present,
    groups => [ 'nas' ],
    system => true,
    gid => 'xbmc',
    password => '*',
    require => Group['nas']
  }
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
