class eizo::tor::install inherits eizo::tor {

  package { 'tor':
    ensure => present
  }

}
