class eizo::miniupnpd::service inherits eizo::miniupnpd {

  file { '/etc/systemd/system/miniupnpd.service':
    ensure => present,
    source => 'puppet:///modules/eizo/miniupnpd/miniupnpd.service',
    notify => Exec['reload systemd']
  }
  ->
  service { 'miniupnpd':
    ensure => running,
    enable => true
  }

}
