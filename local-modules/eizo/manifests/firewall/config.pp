class eizo::firewall::config inherits eizo::firewall {

  file { '/etc/firewall/rules':
    ensure => directory,
    recurse => true,
    purge => true,
    source => "puppet:///modules/eizo/firewall/rules"
  }

  file { '/etc/firewall/qos':
    ensure => directory,
    recurse => true,
    purge => true,
    source => "puppet:///modules/eizo/firewall/qos"
  }

  file { '/etc/ulogd.conf':
    source => "puppet:///modules/eizo/firewall/ulogd.conf",
    owner => "root",
    mode => "go="
  }

}
