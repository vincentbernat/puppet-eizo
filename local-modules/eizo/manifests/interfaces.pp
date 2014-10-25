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

  kernel_parameter { "net.ifnames":
    value => "1"
  }

  create_resources(
    'eizo::interface::physical',
    hiera_hash('eizo::interfaces'),
    { notify => Service["systemd-networkd"] })

}
