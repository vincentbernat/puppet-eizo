class eizo::xbmc::install inherits eizo::xbmc {

  package { ['xbmc', 'xbmc-eventclients-xbmc-send']:
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
    groups => [ 'audio', 'video' ],
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
    [ 'xserver-xorg', 'xinit', 'x11-xserver-utils' ],
    { ensure => present })

}
