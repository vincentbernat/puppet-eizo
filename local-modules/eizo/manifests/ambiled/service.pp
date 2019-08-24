class eizo::ambiled::service inherits eizo::ambiled {

  file { '/etc/systemd/system/ambiled.service':
    ensure => present,
    source => "puppet:///modules/eizo/ambiled/ambiled.service",
    notify => Exec["reload systemd"]
  }
  ->
  service { 'ambiled':
    enable => false,
    ensure => stopped
  }

}
