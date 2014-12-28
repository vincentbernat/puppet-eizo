class eizo::flexget::service inherits eizo::flexget {

  cron { flexget:
    command => "(${home}/venv/bin/flexget --cron execute 3>&1 1>&2 2>&3 | grep -v InsecureRequestWarning) 3>&1 1>&2 2>&3",
    user => "flexget",
    minute => '*/22'
  }

}
