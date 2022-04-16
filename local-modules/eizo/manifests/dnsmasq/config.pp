class eizo::dnsmasq::config inherits eizo::dnsmasq {

  $dhcp = lookup(lookup("eizo::dnsmasq::dhcp"), {merge=>hash})
  $dhcp_hosts = lookup("eizo::dnsmasq::dhcp_hosts", {merge=>hash})
  $unbound_port = 5352

  file { '/etc/unbound/unbound.conf.d/alternative-port.conf':
    content => template("eizo/dnsmasq/unbound.conf.erb")
  }
  file { '/etc/dnsmasq.conf':
    ensure => present,
    content => template("eizo/dnsmasq/dnsmasq.conf.erb")
  }

  file { '/etc/dhcp/dhclient-enter-hooks.d/dnsmasq-resolvconf':
    source => "puppet:///modules/eizo/dnsmasq/dnsmasq-resolvconf"
  }

  file { '/etc/resolv.conf':
    content => "search home.arpa\nnameserver 127.0.0.1\n"
  }

}
