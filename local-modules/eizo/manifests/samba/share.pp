define eizo::samba::share($config) {
    concat::fragment { "smb.${name}.conf":
      target => "/etc/samba/smb.conf",
      content => template("eizo/samba/share.conf.erb"),
      order => '10'
    }
}
