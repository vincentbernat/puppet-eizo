class eizo::flexget($home, $version="1.2.209") {

  class { '::eizo::flexget::install': } ->
  class { '::eizo::flexget::config':  } ~>
  class { '::eizo::flexget::service': } ->
  Class [ '::eizo::flexget' ]

}
