class eizo::miniupnpd {

  class { '::eizo::miniupnpd::install': } ->
  class { '::eizo::miniupnpd::config':  } ~>
  class { '::eizo::miniupnpd::service': } ->
  Class[ '::eizo::miniupnpd' ]

}
