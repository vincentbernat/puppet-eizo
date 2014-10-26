class eizo::firewall::config inherits eizo::firewall {

  file { '/etc/firewall/rules':
    ensure => directory,
    recurse => true,
    purge => true,
    source => "puppet:///modules/eizo/firewall/rules"
  }

  file { '/etc/ulogd.conf':
    source => "puppet:///modules/eizo/firwall/ulogd.conf"
  }

}
