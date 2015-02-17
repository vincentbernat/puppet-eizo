class eizo::tor::config inherits eizo::tor {

  file { '/etc/tor/torrc':
    content => template('eizo/tor/torrc.erb')
  }

}
