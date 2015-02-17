class eizo::tor::service inherits eizo::tor {

  service { 'tor':
    ensure  => running,
    enable  => true,
    restart => 'systemctl reload tor'
  }

}
