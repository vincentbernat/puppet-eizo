class eizo::transmission::install inherits eizo::transmission {

  File {
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
    mode => "0755",
    owner => root,
    group => root
  }
  ->
  file { ["${download}/incomplete", "${download}/complete"]:
    ensure => directory,
    owner => "debian-transmission",
    group => "nas",
    mode => "g=rwxs"
  }
  ->
  file { "${download}/watch":
    ensure => directory,
    mode => "g=rx,o=rwxt",
    owner => "debian-transmission",
    group => "debian-transmission"
  }

}
