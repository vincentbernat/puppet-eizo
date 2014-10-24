# Configure physical interfaces. No IP configuration is done here. We
# just create the physical and logical (VLAN) interfaces. The
# configuration is done through systemd.
class eizo::interfaces {

  exec { 'reload systemd for network interfaces':
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'systemctl daemon-reload'
  }

  create_resources(
    'eizo::interface::physical',
    hiera_hash('eizo::interfaces'),
    { notify => Exec["reload systemd for network interfaces"] })

}
