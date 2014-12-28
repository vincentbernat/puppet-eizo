class eizo::flexget::service inherits eizo::flexget {

  cron { flexget:
    command => "${home}/venv/bin/flexget --cron execute",
    user => "flexget",
    minute => '*/22'
  }

}
