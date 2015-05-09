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

}
