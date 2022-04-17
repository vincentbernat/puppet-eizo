class eizo::kodi::service inherits eizo::kodi {

  file { '/etc/systemd/system/kodi.service':
    ensure => present,
    source => "puppet:///modules/eizo/kodi/kodi.service",
    notify => Exec["reload systemd"]
  }
  ->
  service { 'kodi':
    enable => true,
    ensure => running
  }

  # And regular cleanup of video library
  cron { kodi-backup:
    command => 'mysqldump --all-databases | gzip -c > /srv/media/data/mysqldump-$(date -I).gz',
    hour => 1,
    minute => 10,
    weekday => 1
  }
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

}
