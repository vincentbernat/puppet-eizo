class eizo::transmission(
  $download,
  $config = {}
  ) {

  class { '::eizo::transmission::install': } ->
  class { '::eizo::transmission::config':  } ~>
  class { '::eizo::transmission::service': } ->
  Class [ '::eizo::transmission' ]

}
