class eizo::postfix::service inherits eizo::postfix {

  service { postfix:
    ensure => running,
  }

}
