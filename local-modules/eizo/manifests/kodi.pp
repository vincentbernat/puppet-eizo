class eizo::kodi($home) {
  class { '::eizo::kodi::install': } ->
  class { '::eizo::kodi::config':  } ~>
  class { '::eizo::kodi::service': } ->
  Class[ '::eizo::kodi' ]
}
