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

  shellvar { 'GRUB_CMDLINE_LINUX':
    ensure       => present,
    target       => '/etc/default/grub',
    value        => 'net.ifnames=1',
    array_append => true,
    array_type   => 'double',
  }
  ~>
  exec { "udpate GRUB configuration":
    cmd => "/usr/sbin/update-grub",
    refreshonly => true
  }

  create_resources(
    'eizo::interface::physical',
    hiera_hash('eizo::interfaces'),
    { notify => Service["systemd-networkd"] })

}
