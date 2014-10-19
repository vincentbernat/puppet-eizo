class eizo::xbmc::service inherits eizo::xbmc {

  file { '/usr/local/bin/xbmc-xinit':
    ensure => present,
    source => "puppet:///modules/eizo/xbmc/xbmc-xinit",
    mode => 'a+x'
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
    ensure => running,
    enable => true
  }

}
