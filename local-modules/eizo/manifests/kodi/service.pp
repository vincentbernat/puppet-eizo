class eizo::kodi::service inherits eizo::kodi {

  file { '/etc/systemd/system/kodi.service':
    ensure => absent,
  }
  service { 'lightdm':
    enable => true,
    ensure => running
  }

}
