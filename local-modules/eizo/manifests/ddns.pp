#
# Dynamic DNS update using Route53
#
class eizo::ddns($key, $secret, $domain, $ttl=60) {

  file { "/usr/local/bin/ddns-updater":
    content => template("eizo/ddns/ddns-updater.erb"),
    owner => root,
    mode => "0700"
  }

  file { "/etc/systemd/system/ddns-updater.service":
    source => "puppet:///modules/eizo/ddns/ddns-updater.service",
    notify => Exec["reload systemd"]
  }
  ->
  file { '/etc/dhcp/dhclient-exit-hooks.d/ddns-updater':
    content => "systemctl start ddns-updater || true\n"
  }

  file { "/etc/systemd/system/ddns-updater.timer":
    source => "puppet:///modules/eizo/ddns/ddns-updater.timer",
    require => File["/etc/systemd/system/ddns-updater.service"],
    notify => Exec["reload systemd"]
  }

  ensure_resource(
    package,
    'python-boto',
    { ensure => present })

}
