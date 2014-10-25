class eizo::transmission::service inherits eizo::transmission {

  file { '/etc/systemd/system/transmission-daemon.service':
    ensure => present,
    source => "puppet:///modules/eizo/transmission/transmission-daemon.service",
    notify => Exec["reload systemd"]
  }
  ->
  service { 'transmission-daemon':
    ensure => running,
    enable => true,
    restart => "systemctl reload transmission-daemon"
  }

}
