#
# Setup firewall (in fact, that does a lot more, like IPv4 and IPv6
# setup)
#

class eizo::firewall($ips = {}) {

  class { '::eizo::firewall::install': } ->
  class { '::eizo::firewall::config':  } ~>
  class { '::eizo::firewall::service': } ->
  Class[ '::eizo::firewall' ]

}
