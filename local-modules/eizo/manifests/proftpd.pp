class eizo::proftpd($port, $users) {

  class { '::eizo::proftpd::install': } ->
  class { '::eizo::proftpd::config':  } ~>
  class { '::eizo::proftpd::service': } ->
  Class [ '::eizo::proftpd' ]

}
