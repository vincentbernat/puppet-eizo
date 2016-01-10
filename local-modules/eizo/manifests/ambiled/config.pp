class eizo::ambiled::config inherits eizo::ambiled {

  file { "/etc/hyperion.json":
    source => "puppet:///modules/eizo/ambiled/hyperion.json"
  }
  udev::rule { "90-ambiled.rules":
    content => 'ACTION=="add|change", SUBSYSTEM=="tty", ENV{ID_SERIAL_SHORT}=="AI02Q09P", SYMLINK+="ambiled", OWNER="ambiled"',
  }

}
