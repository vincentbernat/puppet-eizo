class eizo::ssh {

  package { 'openssh-server': ensure => installed }

  sshd_config { 'PermitRootLogin':
    ensure => present,
    value  => 'no'
  }

  sshd_config { 'PasswordAuthentication':
    ensure => present,
    value  => 'no'
  }

  sshd_config { 'UseDNS':
    ensure => present,
    value  => 'no'
  }

  Sshd_config {
    notify  => Service[ssh],
    require => Package['openssh-server']
  }

  service { 'ssh':
    ensure  => running,
    require => Package['openssh-server']
  }

}
