class eizo::kodi::config inherits eizo::kodi {

  # Setup a crontab for Artwork Downloader
  cron { kodi-artwork-downloader:
    command => '/usr/bin/kodi-send --action="RunScript(script.artwork.downloader,silent=true)" > /dev/null',
    user => 'xbmc',
    hour => 3,
    minute => 4,
    monthday => '*/3'
  }

  # And regular cleanup of video library
  cron { kodi-clean-library:
    command => '/usr/bin/kodi-send --action="CleanLibrary(video,silent=true)" > /dev/null',
    user => 'xbmc',
    hour => 3,
    minute => 45
  }

  # Install our own advanced settings
  file { "${home}/userdata/advancedsettings.xml":
    source => "puppet:///modules/eizo/kodi/advancedsettings.xml"
  }
  # And keymaps
  file { "${home}/userdata/keymaps/flirc.xml":
    source => "puppet:///modules/eizo/kodi/flirc.xml"
  }

  # Autostart is done by lightdm
  file { "/etc/lightdm/lightdm.conf":
    source => "puppet:///modules/eizo/kodi/lightdm.conf"
  }
}
