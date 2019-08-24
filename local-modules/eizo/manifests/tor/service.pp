class eizo::tor::service inherits eizo::tor {

  service { 'tor':
    ensure  => stopped,
    enable  => false,
    restart => 'systemctl reload tor'
  }

}
