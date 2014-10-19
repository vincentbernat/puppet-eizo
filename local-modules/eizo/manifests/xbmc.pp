class eizo::xbmc(
  $home,
  $edid = undef
  ) {

  class { '::eizo::xbmc::install': } ->
  class { '::eizo::xbmc::config':  } ~>
  class { '::eizo::xbmc::service': } ->
  Class [ '::eizo::xbmc' ]

}
