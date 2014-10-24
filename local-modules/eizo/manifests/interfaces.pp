# Configure physical interfaces. No IP configuration is done here. We
# just create the physical and logical (VLAN) interfaces. The
# configuration is done through systemd.
class eizo::interfaces {

  service { "systemd-networkd":
    ensure => running,
    enable => true,
    restart => "systemctl daemon-reload"
  }

  create_resources(
    'eizo::interface::physical',
    hiera_hash('eizo::interfaces'),
    { notify => Service["systemd-networkd"] })

}
