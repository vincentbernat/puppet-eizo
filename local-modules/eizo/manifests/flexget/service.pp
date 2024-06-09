class eizo::flexget::service inherits eizo::flexget {

  cron::job { flexget:
    command => "/usr/local/bin/flexget-cron run",
    user    => "flexget",
    minute  => '33'
  }

  cron::job { flexget-move:
    command => "/usr/local/bin/flexget-cron move",
    user    => "xbmc",
    minute  => '*/10'
  }

}
