class eizo::transmission::config inherits eizo::transmission {

  file { '/etc/transmission-daemon/settings.json.puppet':
    ensure => present,
    content => template("eizo/transmission/settings.json.erb"),
  }
  ~>
  exec { "copy transmission-daemon settings":
    refreshonly => true,
    path => [ '/bin', '/sbin' ],
    refreshonly => true,
    command => 'cp /etc/transmission-daemon/settings.json.puppet /etc/transmission-daemon/settings.json'
  }
  ~>
  file { "/etc/transmission-daemon/settings.json":
    mode => "0600",
    owner => "debian-transmission",
    group => "debian-transmission"
  }

}
