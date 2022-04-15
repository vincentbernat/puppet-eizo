class eizo::samba::install inherits eizo::samba {

  package { samba:
    ensure => installed
  }

}
