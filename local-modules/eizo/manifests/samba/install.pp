class eizo::samba::install inherits eizo::samba {

  package { [samba, samba-vfs-modules]:
    ensure => installed
  }

}
