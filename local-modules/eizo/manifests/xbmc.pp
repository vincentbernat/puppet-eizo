#
# $screen is expected to be the screen we should wait to be online
# before starting XBMC. This should use the DRM notation, something
# like `card0-HDMI-XX'. Its name can be found in `/sys/class/drm'.
#

class eizo::xbmc($home, $screen=undef) {

  class { '::eizo::xbmc::install': } ->
  class { '::eizo::xbmc::config':  } ~>
  class { '::eizo::xbmc::service': } ->
  Class [ '::eizo::xbmc' ]

}
