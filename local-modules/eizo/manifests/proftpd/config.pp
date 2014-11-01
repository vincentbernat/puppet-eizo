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
    content => template("eizo/proftp/users.erb")
  }
  create_resources(
    'eizo::proftpd::user',
    $users,
    {})

}
