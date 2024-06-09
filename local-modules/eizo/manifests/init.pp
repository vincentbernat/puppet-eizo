class eizo {

  Stage['main'] -> stage { 'last': }

  # System stuff
  include ::eizo::debian
  include ::eizo::disk
  include ::eizo::postfix
  include ::eizo::ddns
  include ::eizo::ssh
  include ::eizo::system
  include ::eizo::nfs
  include ::mysql::server

  # Applications
  include ::eizo::kodi
  include ::eizo::transmission
  include ::eizo::flexget
  include ::eizo::nginx
  include ::eizo::munin

  # Router stuff
  include ::eizo::interfaces
  include ::eizo::dnsmasq
  include ::eizo::proftpd
  class { "::eizo::firewall":
    stage => last
  }

  # Defaults
  exec { 'reload systemd':
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'systemctl daemon-reload'
  }
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
