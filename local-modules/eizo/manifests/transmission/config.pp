class eizo::transmission::config inherits eizo::transmission {

  file { '/etc/transmission-daemon/settings.json':
    ensure => present,
    content => template("eizo/transmission/settings.json.erb"),
    group => "debian-transmission",
    mode => "0750"
  }

}
