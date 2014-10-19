class eizo::transmission::config inherits eizo::transmission {

  file { '/etc/transmission-daemon/settings.json':
    ensure => present,
    content => template("eizo/transmission/settings.json.erb"),
    mode => "0600",
    owner => "debian-transmission",
    group => "debian-transmission"
  }

}
