class eizo::transmission::install inherits eizo::transmission {

  File {
    owner => "debian-transmission",
    group => "debian-transmission",
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
    mode => "0755"
  }
  ->
  file { ["${download}/incomplete", "${download}/complete"]:
    ensure => directory,
    group => "nas",
    mode => "g=rwxs"
  }
  ->
  file { "${download}/watch":
    ensure => directory,
    mode => "g=rx,o=rwxt"
  }

}
