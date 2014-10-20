class eizo::flexget::service inherits eizo::flexget {

  cron { flexget:
    command => "${home}/venv/bin/flexget --cron",
    user => "flexget",
    minute => '*/15'
  }

}
