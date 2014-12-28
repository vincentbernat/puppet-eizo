class eizo::flexget($home, $config, $version="1.2.242") {

  class { '::eizo::flexget::install': } ->
  class { '::eizo::flexget::config':  } ~>
  class { '::eizo::flexget::service': } ->
  Class [ '::eizo::flexget' ]

}
