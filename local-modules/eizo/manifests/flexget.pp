class eizo::flexget(
  $home,
  $config,
  $move_from,
  $move_to,
  $version="2.10.82") {

  class { '::eizo::flexget::install': } ->
  class { '::eizo::flexget::config':  } ~>
  class { '::eizo::flexget::service': } ->
  Class[ '::eizo::flexget' ]

}
