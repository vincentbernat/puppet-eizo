class eizo {

  # System stuff
  include ::eizo::debian
  include ::eizo::disk
  include ::eizo::postfix
  include ::eizo::ddns

  # Applications
  include ::eizo::xbmc
  include ::eizo::transmission
  include ::eizo::flexget
  include ::eizo::nginx

  # Defaults
  Service {
    provider => "systemd"
  }
  File {
    owner => "root",
    group => "root"
  }

  group { 'nas':
    ensure => present,
    system => true
  }

}
