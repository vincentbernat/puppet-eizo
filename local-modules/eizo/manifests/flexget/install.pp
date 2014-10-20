class eizo::flexget::install inherits eizo::flexget {

  group { 'flexget':
    ensure => present,
    system => true
  }
  ->
  user { 'flexget':
    ensure => present,
    gid => 'flexget',
    comment => 'Flexget user',
    home => $home,
    system => true,
    password => '*'
  }
  ->
  python::virtualenv { "${home}/venv":
  }
  ->
  python::pip { 'flexget':
    pkgname => "FlexGet==${version}",
    virtualenv => "${home}/venv",
  }

}
