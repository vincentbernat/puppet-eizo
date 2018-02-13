class eizo::flexget::service inherits eizo::flexget {

  cron { flexget:
    command => "/usr/local/bin/flexget-cron run",
    user    => "flexget",
    minute  => '*/33'
  }

  cron { flexget-move:
    command => "/usr/local/bin/flexget-cron move",
    user    => "xbmc",
    minute  => '*/10'
  }

}
