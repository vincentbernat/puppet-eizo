class eizo::dnsmasq {

  class { '::eizo::dnsmasq::install': } ->
  class { '::eizo::dnsmasq::config':  } ~>
  class { '::eizo::dnsmasq::service': } ->
  Class[ '::eizo::dnsmasq' ]

}
