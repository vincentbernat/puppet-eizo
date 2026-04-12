class eizo::proftpd::install inherits eizo::proftpd {

  package { ['proftpd-core', 'proftpd-mod-crypto']:
    ensure => present
  }

}
