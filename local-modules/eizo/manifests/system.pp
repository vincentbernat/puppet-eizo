class eizo::system {

  file { "/etc/systemd/logind.conf":
    source => "puppet:///modules/eizo/system/logind.conf"
  }

}
