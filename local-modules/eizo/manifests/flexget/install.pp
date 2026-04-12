class eizo::flexget::install inherits eizo::flexget {

  package { 'python3-venv':
    ensure => present
  }
  ->
  class { 'python':
    version => '3',
    pip     => absent
  }

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
  }

  # TODO: make it work again
  # python::pip { 'flexget':
  #   pkgname    => "FlexGet",
  #   ensure     => "${version}",
  #   virtualenv => "${home}/venv"
  # }
  # package { 'nodejs': ensure => installed }
  # ->
  # python::pip { ['transmission-rpc', 'cfscrape', 'cloudscraper']:
  #   virtualenv => "${home}/venv"
  # }
  #
  # Currently:
  #  venv/bin/python3 -m pip install "cython<3"
  #  venv/bin/python3 -m pip install "pyyaml==6.0"
  #  venv/bin/python3 -m pip install FlexGet==3.19.10 transmission-rpc
  #

  file { '/usr/local/bin/flexget-cron':
    content => template('eizo/flexget/cron.erb'),
    mode    => '0755'
  }

}
