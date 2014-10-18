class eizo::postfix::install inherits eizo::postfix {

  package { postfix:
    ensure => installed
  }

}
