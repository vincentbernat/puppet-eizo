# Configure /etc/network/interfaces
class eizo::interfaces {

  $interfaces = hiera_hash('eizo::interfaces')
  create_resources(
    'eizo::interface::ifup',
    $interfaces,
    {})

  # Enable dhclient for the given set of interfaces
  file { "/etc/network/interfaces":
    content => "auto lo\niface lo inet loopback\nsource-directory interfaces.d\n"
  }
  file { '/etc/network/interfaces.d':
    ensure  => directory,
    recurse => true,
    purge   => true
  }

  package { 'sipcalc': ensure => installed }
  -> file { '/etc/dhcp/dhclient-exit-hooks.d/000-ipv6-pd':
    content => template('eizo/interfaces/ipv6-pd')
  }
  -> concat { "/etc/dhcp/dhclient.conf":
    ensure => present
  }
  concat::fragment { "dhclient-header.conf":
    target => "/etc/dhcp/dhclient.conf",
    source => "puppet:///modules/eizo/interfaces/dhclient-header.conf",
    order => '00'
  }

  # Don't use persistant names
  kernel_parameter { "net.ifnames":
    provider => "grub2",
    value => "1"
  }

  shellvar { 'AVAHI_DAEMON_DETECT_LOCAL':
    ensure => present,
    target => '/etc/default/avahi-daemon',
    value  => '0',
  }


}
