class eizo::transmission::service inherits eizo::transmission {

  file { '/etc/systemd/system/transmission-daemon.service':
    ensure => present,
    source => "puppet:///modules/eizo/transmission/transmission-daemon.service"
  }
  ~>
  exec { 'reload systemd for transmission':
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'systemctl daemon-reload'
  }
  ->
  service { 'transmission-daemon':
    ensure => running,
    enable => true,
    restart => "systemctl reload transmission-daemon"
  }

}
