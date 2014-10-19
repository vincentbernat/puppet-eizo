class eizo::xbmc::install inherits eizo::xbmc {

  apt::source { "xbmc-ffmpeg":
    comment       => "XBMC repository with ffmpeg",
    location      => 'https://people.debian.org/~rbalint/ppa/xbmc-ffmpeg',
    release       => 'xbmc-ffmpeg-unstable/',
    repos         => '',
    key           => '21E764DF',
    pin           => 1,
    include_src   => false
  }
  ->
  apt::pin { "xbmc":
    priority => 500,
    label => "rbalint",
    packages => "xbmc"
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
    [ 'xserver-xorg', 'xinit', 'x11-xserver-utils' ],
    { ensure => present })

}
