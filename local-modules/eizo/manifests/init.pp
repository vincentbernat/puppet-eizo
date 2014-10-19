class eizo {

  # System stuff
  include ::eizo::debian
  include ::eizo::disk
  include ::eizo::postfix

  # Applications
  include ::eizo::xbmc
  include ::eizo::transmission

  # Defaults
  Service {
    provider => "systemd"
  }
  File {
    owner => "root",
    group => "root"
  }

}
