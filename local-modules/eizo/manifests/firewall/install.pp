class eizo::firewall::install inherits eizo::firewall {

  package { ['iptables', 'ebtables', 'iproute2', 'ulogd2', 'conntrack']:
    ensure => installed
  }

  file { '/etc/firewall':
    ensure => directory
  }
  file { '/etc/firewall/run':
    source => "puppet:///modules/eizo/firewall/run",
    mode => "a+x"
  }

}
