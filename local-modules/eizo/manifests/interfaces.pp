# Configure /etc/network/interfaces
class eizo::interfaces {

  $interfaces = lookup('eizo::interfaces', {merge=>hash})
  create_resources(
    'eizo::interface::ifup',
    $interfaces,
    {})

  file { "/etc/network/interfaces":
    content => "auto lo\niface lo inet loopback\nsource-directory interfaces.d\n"
  }
  file { '/etc/network/interfaces.d':
    ensure  => directory,
    recurse => true,
    purge   => true
  }

  # Don't use persistant names
  kernel_parameter { "net.ifnames":
    provider => "grub2",
    value => "1"
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
