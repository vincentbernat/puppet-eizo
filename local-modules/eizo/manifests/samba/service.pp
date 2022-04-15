class eizo::samba::service inherits eizo::samba {

  service { smbd:
    ensure => running,
  }
  service { nmbd:
    ensure => stopped,
    enable => false,
  }

}
