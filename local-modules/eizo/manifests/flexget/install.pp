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
    require => Package['virtualenv'],
    before => [ Python::Pip['flexget'],
                Python::Pip['transmissionrpc'],
                Python::Pip['cfscrape'] ]
  }

  python::pip { 'flexget':
    pkgname => "FlexGet==${version}",
    virtualenv => "${home}/venv"
  }
  python::pip { 'transmissionrpc':
    virtualenv => "${home}/venv"
  }
  package { 'nodejs-legacy': ensure => installed }
  ->
  python::pip { 'cfscrape':
    virtualenv => "${home}/venv"
  }

  file { '/usr/local/bin/flexget-cron':
    content => template('eizo/flexget/cron.erb'),
    mode    => '0755'
  }

  ensure_resource(
    package, [ 'virtualenv' ],
    { ensure => present })

}
