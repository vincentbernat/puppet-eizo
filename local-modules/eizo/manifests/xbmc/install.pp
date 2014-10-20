class eizo::xbmc::install inherits eizo::xbmc {

  apt::source { "xbmc-ffmpeg":
    comment       => "XBMC repository with ffmpeg",
    location      => 'https://people.debian.org/~rbalint/ppa/xbmc-ffmpeg',
    release       => 'xbmc-ffmpeg-unstable/',
    repos         => '',
    key           => '21E764DF',
    include_src   => false
  }
  ->
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
    source => "puppet:///modules/eizo/xbmc/xbmc-start",
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
