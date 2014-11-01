class eizo::proftpd::config inherits eizo::proftpd {

  file { '/etc/proftpd/proftpd.conf':
    ensure => present,
    content => template("eizo/proftpd/proftpd.conf.erb")
  }

  # Users
  file { '/etc/proftpd/users.keys':
    ensure => directory
  }
  file { '/etc/proftpd/users':
    content => template("eizo/proftpd/users.erb"),
    owner => "proftpd",
    mode => "go="
  }
  create_resources(
    'eizo::proftpd::user',
    $users,
    {})

}
