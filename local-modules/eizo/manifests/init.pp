class eizo {

  # System stuff
  include ::eizo::debian
  include ::eizo::disk
  include ::eizo::postfix

  # Applications
  include ::eizo::xbmc

  # Use systemd
  Service {
    provider => "systemd"
  }

}
