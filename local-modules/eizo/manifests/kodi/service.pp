class eizo::kodi::service inherits eizo::kodi {
  # And regular cleanup of video library
  cron::job { kodi-backup:
    command => 'mysqldump --all-databases | gzip -c > /srv/media/data/mysqldump-$(date -I).gz',
    hour => 1,
    minute => 10,
    weekday => 1
  }
  cron::job { kodi-clean-library:
    command => '/usr/bin/kodi-send --host=kodi --action="CleanLibrary(video,silent=true)" > /dev/null',
    user => 'xbmc',
    hour => 3,
    minute => 45
  }
  cron::job { kodi-update-library:
    command => '/usr/bin/kodi-send --host=kodi --action="UpdateLibrary(video)" > /dev/null',
    user => 'xbmc',
    hour => "*/6",
    minute => 5
  }

}
