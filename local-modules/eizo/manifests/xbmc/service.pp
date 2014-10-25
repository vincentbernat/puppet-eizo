class eizo::xbmc::service inherits eizo::xbmc {

  file { '/etc/systemd/system/xbmc.service':
    ensure => present,
    source => "puppet:///modules/eizo/xbmc/xbmc.service",
    notify => Exec["reload systemd"]
  }
  ->
  service { 'xbmc':
    enable => true,
    ensure => running
  }

}
