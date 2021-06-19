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
  python::pyvenv { "${home}/venv":
    before => [ Python::Pip['flexget'],
                Python::Pip['transmissionrpc'],
                Python::Pip['cfscrape'] ]
  }

  python::pip { 'flexget':
    pkgname => "FlexGet",
    ensure => "${version}",
    virtualenv => "${home}/venv"
  }
  python::pip { 'transmissionrpc':
    virtualenv => "${home}/venv"
  }
  package { 'nodejs': ensure => installed }
  ->
  python::pip { 'cfscrape':
    virtualenv => "${home}/venv"
  }

  file { '/usr/local/bin/flexget-cron':
    content => template('eizo/flexget/cron.erb'),
    mode    => '0755'
  }

}
