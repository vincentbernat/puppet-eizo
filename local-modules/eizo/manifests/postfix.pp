class eizo::postfix(
  $relay,
  $relayauth,
  $origin = "${::domain}"
  ) {

  class { '::eizo::postfix::install': } ->
  class { '::eizo::postfix::config':  } ~>
  class { '::eizo::postfix::service': } ->
  Class[ '::eizo::postfix' ]

}
