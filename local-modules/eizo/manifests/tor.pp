class eizo::tor($bind, $transport = 9040, $dnsport = 9041, $bandwidth = "1 MBytes") {

  class { '::eizo::tor::install': } ->
  class { '::eizo::tor::config':  } ~>
  class { '::eizo::tor::service': } ->
  Class [ '::eizo::tor' ]

}
