class eizo::firewall::service inherits eizo::firewall {

  exec { 'reload systemd (firewall)':
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'systemctl daemon-reload'
  }

  file { '/etc/systemd/system/firewall.service':
    ensure => present,
    source => "puppet:///modules/eizo/firewall/firewall.service",
    notify => Exec["reload systemd (firewall)"]
  }
  ->
  service { 'firewall':
    enable => true
  }

  file { ['/etc/dhcp/dhclient-exit-hooks.d/000-ipv6',
          '/etc/dhcp/dhclient-exit-hooks.d/zzz-firewall']:
    ensure => absent
  }

  exec { "firewall reload":
    path => [ "/sbin", "/bin" ],
    command => "systemctl start firewall",
    require => Service["firewall"],
    refreshonly => true
  }

  service { 'ulogd2':
    ensure => running,
    enable => true
  }
}
