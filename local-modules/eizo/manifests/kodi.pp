#
# $screen is expected to be the screen we should wait to be online
# before starting KODI. This should use the DRM notation, something
# like `card0-HDMI-XX'. Its name can be found in `/sys/class/drm'.
#

class eizo::kodi($home, $screen=undef) {

  class { '::eizo::kodi::install': } ->
  class { '::eizo::kodi::config':  } ~>
  class { '::eizo::kodi::service': } ->
  Class [ '::eizo::kodi' ]

}
