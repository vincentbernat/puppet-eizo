define eizo::interface::dhcp($conf) {

  file { "/etc/dhcp/dhclient.${name}.conf":
    content => template("eizo/interfaces/dhclient.conf.erb")
  }
  ~>
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
