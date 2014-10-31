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
  ->
  file { '/etc/dhcp/dhclient-exit-hooks.d/firewall':
    source => "puppet:///modules/eizo/firewall/dhcp-hook"
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
