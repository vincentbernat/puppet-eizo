class eizo::kodi::service inherits eizo::kodi {

  file { '/etc/systemd/system/kodi.service':
    ensure => present,
    source => "puppet:///modules/eizo/kodi/kodi.service",
    notify => Exec["reload systemd"]
  }
  ->
  service { 'kodi':
    enable => true,
    ensure => running
  }

  file { '/etc/systemd/system/xbmc.service':
    ensure => absent,
    notify => Exec["reload systemd"]
  }

}
