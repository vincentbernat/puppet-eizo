class eizo::flexget::service inherits eizo::flexget {

  cron { flexget:
    command => "${home}/venv/bin/flexget execute --cron",
    user => "flexget",
    minute => '18'
  }

}
