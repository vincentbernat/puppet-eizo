class eizo::kodi::install inherits eizo::kodi {

  package { ['kodi', 'kodi-eventclients-kodi-send']:
    ensure => present
  }
  package { 'lightdm': ensure => absent }

  group { 'xbmc':
    ensure => present,
    system => true
  }
  ->
  user { 'xbmc':
    ensure => present,
    gid => 'xbmc',
    groups => [ 'audio', 'video', 'nas' ],
    comment => 'XBMC/Kodi user',
    home => $home,
    system => true,
    password => '*',
    require => Group['nas']
  }
  ->
  file { ["${home}/.kodi", "${home}/.xbmc"]:
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
