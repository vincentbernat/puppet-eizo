class eizo::kodi::config inherits eizo::kodi {

  # And regular cleanup of video library
  cron { kodi-clean-library:
    command => '/usr/bin/kodi-send --action="CleanLibrary(video,silent=true)" > /dev/null',
    user => 'xbmc',
    hour => 3,
    minute => 45
  }
  cron { kodi-update-library:
    command => '/usr/bin/kodi-send --action="UpdateLibrary(video)" > /dev/null',
    user => 'xbmc',
    hour => "*/6",
    minute => 5
  }

  # And keymaps
  file { "${home}/userdata/keymaps/flirc.xml":
    source => "puppet:///modules/eizo/kodi/flirc.xml"
  }
}
