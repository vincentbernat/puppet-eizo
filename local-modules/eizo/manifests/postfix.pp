class eizo::postfix(
  $relay = "smtp.${::domain}",
  $cert = undef,
  $key = undef,
  $origin = "${::domain}"
  ) {

  class { '::eizo::postfix::install': } ->
  class { '::eizo::postfix::config':  } ~>
  class { '::eizo::postfix::service': } ->
  Class[ '::eizo::postfix' ]

}
