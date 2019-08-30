class eizo::nginx {

  include ::nginx
  include ::eizo::nginx::acme

  file { "/etc/nginx/ssl":
    ensure => directory,
    mode => "0755"
  }

  create_resources(
    file,
    hiera_hash("eizo::nginx::certs", {}),
    { notify => Service[nginx] })

  create_resources(
    eizo::nginx::crl,
    hiera_hash("eizo::nginx::crls", {}),
    { notify => Service[nginx] })

}

define eizo::nginx::crl($path=$title, $url) {
  cron { "update-crl-${path}":
    minute => 3,
    hour => 4,
    user => root,
    command => "t=$(mktemp -p $(dirname ${path})) && curl -s -o \$t ${url} && chmod 644 \$t && mv \$t ${path} && /usr/sbin/nginx -s reload"
  }
  exec { "retrieve-${path}":
    path => ["/bin", "/usr/bin"],
    command => "sh -c 't=$(mktemp -p $(dirname ${path})) && curl -s -o \$t ${url} && chmod 644 \$t && mv \$t ${path}'",
    creates => "${path}"
  }
}


class eizo::nginx::acme {

  package { acmetool:
    ensure => installed
  }
  -> file { ['/var/lib/acme', '/var/lib/acme/conf']:
    ensure  => directory,
  }
  -> file { '/var/lib/acme/conf/target':
    source => "puppet:///modules/eizo/nginx/acme.conf"
  }
  -> file { '/etc/default/acme-reload':
    content => "SERVICES=nginx"
  }
  -> service { 'acmetool.timer':
    provider => systemd,
    ensure   => running,
    enable   => true
  }

  exec { "acmetool-reconcile":
    path        => ["/bin", "/usr/bin"],
    command     => "systemctl start acmetool.service",
    refreshonly => true,
    require     => [
      Package[acmetool],
    ]
  }

  create_resources(
    eizo::nginx::acme::certificate,
    hiera_hash("eizo::nginx::acmetool::certificates", {}),
    { notify => Exec[acmetool-reconcile] })

}

define eizo::nginx::acme::certificate($domains=[$title]) {
  file { "/var/lib/acme/desired/${title}":
    content => template("eizo/nginx/acme-cert.erb")
  }
}

