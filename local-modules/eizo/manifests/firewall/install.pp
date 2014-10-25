class eizo::firewall::install inherits eizo::firewall {

  package { ['iptables', 'ip6tables', 'ebtables', 'iproute2']:
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
