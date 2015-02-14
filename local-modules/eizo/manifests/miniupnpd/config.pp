class eizo::miniupnpd::config inherits eizo::miniupnpd {

  $interfaces = hiera_hash('eizo::interfaces')

  file { '/etc/miniupnpd/miniupnpd.conf':
    content => template('eizo/miniupnpd/miniupnpd.conf.erb')
  }
  file { '/etc/miniupnpd/iptables_flush.sh':
    source => 'puppet:///modules/eizo/miniupnpd/iptables_flush.sh',
    mode   => 'a+x'
  }

}
