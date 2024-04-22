class eizo::kodi($home, $screen=undef) {
  class { '::eizo::kodi::install': } ->
  class { '::eizo::kodi::config':  } ~>
  class { '::eizo::kodi::service': } ->
  Class[ '::eizo::kodi' ]
}
