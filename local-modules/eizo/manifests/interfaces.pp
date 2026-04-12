# Configure network with systemd-networkd
class eizo::interfaces {

  $interfaces = lookup('eizo::interfaces', {merge=>hash})
  create_resources(
    'eizo::interface::networkd',
    $interfaces,
    {})

  file { "/etc/network/interfaces":
    content => "auto lo\niface lo inet loopback\nsource-directory interfaces.d\n"
  }
  file { ['/etc/systemd/network', '/etc/network/interfaces.d']:
    ensure  => directory,
    recurse => true,
    purge   => true
  }

  service { 'networking':
    enable => false,
  }
  service { 'systemd-networkd':
    enable => true,
    ensure => running
  }

  # Don't use persistent names
  kernel_parameter { "net.ifnames":
    provider => "grub2",
    value => "0"
  }

  # Avahi
  shellvar { 'AVAHI_DAEMON_DETECT_LOCAL':
    ensure => present,
    target => '/etc/default/avahi-daemon',
    value  => '0',
    notify => Service['avahi-daemon']
  }
  file { '/etc/avahi/avahi-daemon.conf':
    source => "puppet:///modules/eizo/interfaces/avahi-daemon.conf"
  } ~>
  service { 'avahi-daemon':
    enable => true,
    ensure => running
  }

}
