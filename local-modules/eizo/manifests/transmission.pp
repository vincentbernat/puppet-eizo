class eizo::transmission(
  $download,
  $rpcport,
  $config = {}
  ) {

  class { '::eizo::transmission::install': } ->
  class { '::eizo::transmission::config':  } ~>
  class { '::eizo::transmission::service': } ->
  Class [ '::eizo::transmission' ]

}
