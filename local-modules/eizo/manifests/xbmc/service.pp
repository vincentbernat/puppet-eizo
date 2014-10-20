class eizo::xbmc::service inherits eizo::xbmc {

  udev::rule { "99-xbmc.rules":
    source => "puppet:///modules/eizo/xbmc/xbmc.rules"
  }
  ->
  file { '/etc/systemd/system/xbmc.target':
    ensure => present,
    source => "puppet:///modules/eizo/xbmc/xbmc.target",
    notify => Exec['reload systemd for xbmc']
  }
  ->
  file { '/etc/systemd/system/xbmc.service':
    ensure => present,
    source => "puppet:///modules/eizo/xbmc/xbmc.service"
  }
  ~>
  exec { 'reload systemd for xbmc':
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'systemctl daemon-reload'
  }
  ->
  service { 'xbmc':
    enable => true
  }

}
