class eizo::tor($bind, $transport, $dnsport = 53, $bandwidth = "1 MBytes") {

  class { '::eizo::tor::install': } ->
  class { '::eizo::tor::config':  } ~>
  class { '::eizo::tor::service': } ->
  Class [ '::eizo::tor' ]

}
