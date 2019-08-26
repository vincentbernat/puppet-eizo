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

  concat { "/etc/dhcp/dhclient.conf":
    ensure => present
  }
  concat::fragment { "dhclient-header.conf":
    target => "/etc/dhcp/dhclient.conf",
    source => "puppet:///modules/eizo/interfaces/dhclient-header.conf",
    order => '00'
  }

  file { '/etc/dibbler/script.sh':
    source => "puppet:///modules/eizo/interfaces/dibbler.sh",
    mode   => '0755'
  }
  concat { '/etc/dibbler/client.conf':
    ensure => present,
    notify => Service['dibbler-client']
  }
  concat::fragment { 'dibbler-header.conf':
    target => '/etc/dibbler/client.conf',
    source => 'puppet:///modules/eizo/interfaces/dibbler-header.conf',
    order  => '00'
  }
  concat::fragment { 'dibbler-downlink.conf':
    target  => '/etc/dibbler/client.conf',
    order   => '01',
    content => inline_template(@(END)
      downlink-prefix-ifaces <%= @interfaces.select { |name, options| options['v6'] }.keys.sort.map {|x| x.inspect}.join ',' %>
      | END
    )
  }
  service { 'dibbler-client':
    ensure    => running,
    enable    => true
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
