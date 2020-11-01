class eizo::firewall::config inherits eizo::firewall {

  file { '/etc/firewall/rules':
    ensure => directory,
    recurse => true,
    purge => true,
    source => "puppet:///modules/eizo/firewall/rules"
  }

  file { '/etc/ulogd.conf':
    source => "puppet:///modules/eizo/firewall/ulogd.conf",
    owner => "root",
    mode => "go="
  }

  file { '/etc/modprobe.d/no-sip-alg.conf':
    content => @(END)
      blacklist nf_nat_sip
      blacklist nf_conntrack_sip
    | END
  }

}
