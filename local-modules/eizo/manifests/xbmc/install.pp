class eizo::xbmc::install inherits eizo::xbmc {

  apt::pin { 'xbmc from backports':
    priority => 500,
    originator => 'Debian Backports',
    packages => 'xbmc'
  }
  ->
  package { 'xbmc':
    ensure => present
  }

  group { 'xbmc':
    ensure => present,
    system => true
  }
  ->
  user { 'xbmc':
    ensure => present,
    gid => 'xbmc',
    comment => 'XBMC user',
    home => $home,
    system => true,
    password => '*'
  }
  ->
  file { "${home}/.xbmc":
    ensure => link,
    target => "${home}"
  }

  # Also install X stuff. We use `ensure_resource` because we don't
  # want to have ownership.
  ensure_resource(
    package,
    [ 'xserver-xorg', 'xinit' ],
    { ensure => present })

}
