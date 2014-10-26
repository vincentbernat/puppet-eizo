class eizo::firewall::service inherits eizo::firewall {

  file { '/etc/systemd/system/firewall.service':
    ensure => present,
    source => "puppet:///modules/eizo/firewall/firewall.service",
    notify => Exec["reload systemd"]
  }
  ->
  service { 'firewall':
    enable => true
  }
  ->
  file { '/etc/dhcp/dhclient-exit-hooks.d/firewall':
    content => "systemctl start firewall || true\n"
  }

  exec { "firewall reload":
    path => [ "/sbin", "/bin" ],
    command => "systemctl start firewall",
    require => Service["firewall"],
    refreshonly => true
  }

  service { 'ulogd':
    ensure => running,
    enable => true
  }
}
