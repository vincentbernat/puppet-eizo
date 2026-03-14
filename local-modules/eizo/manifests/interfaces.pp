# Configure network with systemd-networkd
class eizo::interfaces {

  $interfaces = lookup('eizo::interfaces', {merge=>hash})
  create_resources(
    'eizo::interface::networkd',
    $interfaces,
    {})

  file { '/etc/systemd/network':
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
