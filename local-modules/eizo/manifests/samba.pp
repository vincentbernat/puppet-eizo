class eizo::samba {

  class { '::eizo::samba::install': } ->
  class { '::eizo::samba::config':  } ~>
  class { '::eizo::samba::service': } ->
  Class[ '::eizo::samba' ]

}
