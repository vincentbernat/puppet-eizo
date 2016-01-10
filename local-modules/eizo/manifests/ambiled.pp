class eizo::ambiled {

  class { '::eizo::ambiled::install': } ->
  class { '::eizo::ambiled::config':  } ~>
  class { '::eizo::ambiled::service': } ->
  Class [ '::eizo::ambiled' ]

}
