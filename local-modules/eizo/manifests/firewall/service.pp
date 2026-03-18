class eizo::firewall::service inherits eizo::firewall {

  exec { 'reload systemd (firewall)':
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'systemctl daemon-reload'
  }

  $interfaces = lookup('eizo::interfaces', {merge => hash})
  file { '/etc/systemd/system/firewall.service':
    ensure  => present,
    content => template("eizo/firewall/firewall.service.erb"),
    notify  => Exec["reload systemd (firewall)"]
  }
  ->
  service { 'firewall':
    enable => true
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
