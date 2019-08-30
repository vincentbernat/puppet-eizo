class eizo::kodi::install inherits eizo::kodi {

  package { ['kodi', 'kodi-eventclients-kodi-send']:
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
    groups => [ 'audio', 'video', 'nas' ],
    comment => 'XBMC/Kodi user',
    home => $home,
    system => true,
    password => '*',
    require => Group['nas']
  }
  ->
  file { "${home}/.kodi":
    ensure => link,
    target => "${home}"
  }
  ->
  file { "${home}/.xbmc":
    ensure => link,
    target => "${home}"
  }

  file { "/usr/local/bin/kodi-start":
    content => template("eizo/kodi/kodi-start.erb"),
    mode => "a+x"
  }
  file { "/usr/local/bin/kodi-stop":
    source => "puppet:///modules/eizo/kodi/kodi-stop",
    mode => "a+x"
  }

  # Also install X stuff. We use `ensure_resource` because we don't
  # want to have ownership.
  ensure_resource(
    package,
    [ 'xserver-xorg', 'xinit', 'x11-xserver-utils' ],
    { ensure => present })

}
