class eizo::system {

  file { "/etc/systemd/logind.conf":
    source => "puppet:///modules/eizo/system/logind.conf"
  }

  # Log with systemd-journald only
  package { ["rsyslog", "syslog-ng"]:
    ensure => absent
  }
  file { "/var/log/journal":
    ensure => directory,
    group => "systemd-journal"
  }
  exec { "Set ACL on /var/log/journal":
    command => "/usr/bin/setfacl -R -nm g:adm:rx,d:g:adm:rx /var/log/journal",
    unless => "/usr/bin/getfacl /var/log/journal | /bin/grep '^group:adm:r-x' && /usr/bin/getfacl /var/log/journal | /bin/grep '^default:group:adm:r-x'",
    require => Package["acl"]
  }
  package { "acl": ensure => installed }

  package { "sudo": ensure => installed }
  ->
  file { '/etc/environment':
    content => @(ENV/L)
      # Managed by Puppet
      LESSSECURE=1
      | ENV
  }
  ->
  file_line { 'make sudo read /etc/environment':
    require => Package[sudo],
    line    => 'session required pam_env.so',
    path    => '/etc/pam.d/sudo',
    after   => "#%PAM-1.0"
  }
  ->
  file { "/etc/sudoers.d/nopasswd": content => template("eizo/system/sudo-nopasswd") }

  package { 'fwupd': ensure => installed }
}
