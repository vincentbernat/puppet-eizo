class eizo::system {

  file { "/etc/systemd/logind.conf":
    source => "puppet:///modules/eizo/system/logind.conf"
  }

  # Log with systemd-journald only. Cron with systemd-cron only.
  package { "systemd-cron": ensure => installed }
  ->
  package { ["rsyslog", "syslog-ng", "cron"]:
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
  file { "/etc/sudoers.d/nopasswd": content => template("eizo/system/sudo-nopasswd") }

  package { 'fwupd': ensure => installed }
}
