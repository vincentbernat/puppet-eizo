class eizo::xbmc($home) {

  class { '::eizo::xbmc::install': } ->
  class { '::eizo::xbmc::config':  } ~>
  class { '::eizo::xbmc::service': } ->
  Class [ '::eizo::xbmc' ]

}
