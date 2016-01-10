class eizo::ambiled::install inherits eizo::ambiled {

  # Installation is manual.

  group { 'ambiled':
    ensure => present,
    system => true
  }
  ->
  user { 'ambiled':
    ensure => present,
    gid => 'ambiled',
    comment => 'ambiled user',
    home => "/var/run/ambiled",
    system => true,
    password => '*'
  }

}
