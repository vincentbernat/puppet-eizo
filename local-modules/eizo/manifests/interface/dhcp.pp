define eizo::interface::dhcp {

  exec { "enable DHCP for $name":
    command => "systemctl enable dhclient@$name",
    path => [ "/bin", "/sbin" ],
    creates => "/etc/systemd/system/multi-user.target.wants/dhclient@$name.service"
  }

  # This could be as simple as...
  # service { "dhclient@$name":
  #   enable => true
  # }

}
