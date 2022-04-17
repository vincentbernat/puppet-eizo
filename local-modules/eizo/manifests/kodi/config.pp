class eizo::kodi::config inherits eizo::kodi {
  # Keymaps
  file { "${home}/userdata/keymaps/flirc.xml":
    source => "puppet:///modules/eizo/kodi/flirc.xml"
  }
}
