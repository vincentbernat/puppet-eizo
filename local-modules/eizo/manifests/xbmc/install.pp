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
    groups => [ 'audio', 'video', 'nas' ],
    comment => 'XBMC user',
    home => $home,
    system => true,
    password => '*',
    require => Group['nas']
  }
  ->
  file { "${home}/.xbmc":
    ensure => link,
    target => "${home}"
  }

  file { "/usr/local/bin/xbmc-start":
    content => template("eizo/xbmc/xbmc-start.erb"),
    mode => "a+x"
  }
  file { "/usr/local/bin/xbmc-stop":
    source => "puppet:///modules/eizo/xbmc/xbmc-stop",
    mode => "a+x"
  }

  # Also install X stuff. We use `ensure_resource` because we don't
  # want to have ownership.
  ensure_resource(
    package,
    [ 'xserver-xorg', 'xinit', 'x11-xserver-utils' ],
    { ensure => present })

}
