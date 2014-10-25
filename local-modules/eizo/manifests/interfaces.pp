# Configure physical interfaces. No IP configuration is done here. We
# just create the physical and logical (VLAN) interfaces. The
# configuration is done through systemd.
#
# See this bug:
#  https://bugs.freedesktop.org/show_bug.cgi?id=85440
#
class eizo::interfaces {

  service { "systemd-networkd":
    ensure => running,
    enable => true
  }

  # Let systemd/udev handle device names
  kernel_parameter { "net.ifnames":
    provider => "grub2",
    value => "1"
  }

  create_resources(
    'eizo::interface::physical',
    hiera_hash('eizo::interfaces'),
    { notify => Service["systemd-networkd"] })

  # Enable dhclient for the given set of interfaces
  file { "/etc/network/interfaces":
    content => "auto lo\niface lo inet loopback\n"
  }
  file { "/etc/systemd/system/dhclient@.service":
    source => "puppet:///modules/eizo/interfaces/dhclient@.service",
    notify => Exec["reload systemd"]
  }

  create_resources(
    'eizo::interface::dhcp',
    hiera_hash('eizo::dhcp'),
    {
      require => File["/etc/systemd/system/dhclient@.service"],
      notify => Exec["reload systemd"]
    })

}
