#
# Dynamic DNS update using Route53
#
class eizo::ddns($key, $secret, $domain, $ttl=60) {

  file { "/usr/local/bin/ddns-updater":
    content => template("eizo/ddns/ddns-updater.erb"),
    owner => root,
    mode => "0700"
  }

  cron { "ddns-updater":
    command => "/usr/local/bin/ddns-updater",
    minute => '*/10',
    require => File['/usr/local/bin/ddns-updater']
  }

  file { '/etc/dhcp/dhclient-exit-hooks.d/ddns-updater':
    content => "/usr/local/bin/ddns-updater || true\n"
  }

  ensure_resource(
    package,
    'python-boto',
    { ensure => present })

}
