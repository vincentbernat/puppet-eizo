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
    crl,
    hiera_hash("eizo::nginx::crls", {}),
    { notify => Service[nginx] })

  define crl($path=$title, $url) {
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
}

class eizo::nginx::acme {

  # TODO: install acmetool
  # TODO: run "sudo -u acmetool acmetool quickstart"
  # TODO: setup hooks
  # package { acmetool:
  #   ensure => installed
  # }

  user { acmetool:
    ensure  => present,
    comment => "User for Let's encrypt",
    system  => true,
    gid     => daemon,
    home    => '/var/empty'
  }
  ->
  file { '/var/run/acme/acme-challenge/':
    ensure => directory,
    owner  => acmetool,
    group  => root,
    mode   => '0755'
  }

  file { '/var/run/acme':
    ensure => directory
  }
  file { ['/var/lib/acme', '/var/lib/acme/conf', '/var/lib/acme/desired']:
    ensure  => directory,
    owner   => acmetool,
    require => User[acmetool]
  }
  file { '/var/lib/acme/conf/target':
    source => "puppet:///modules/eizo/nginx/acme.conf"
  }
  file { '/etc/default/acme-reload':
    content => "SERVICES=nginx"
  }

  exec { "acmetool-reconcile":
    path        => ["/bin", "/usr/bin"],
    command     => "acmetool --batch reconcile",
    user        => acmetool,
    refreshonly => true,
    require     => [
      User[acmetool],
      File['/etc/default/acme-reload'],
      File['/var/lib/acme/conf/target'],
      File['/etc/sudoers.d/acmetool'],
    ]
  }

  file { "/etc/sudoers.d/acmetool":
    content => "acmetool ALL=(root) NOPASSWD: /etc/acme/hooks/"
  }

  cron { "acmetool-reconcile":
    minute  => 41,
    hour    => 17,
    command => "/usr/bin/acmetool --batch reconcile",
    user    => acmetool,
    require     => [
      User[acmetool],
      File['/etc/default/acme-reload'],
      File['/var/lib/acme/conf/target'],
      File['/etc/sudoers.d/acmetool'],
    ]
  }

  create_resources(
    eizo::nginx::acme::certificate,
    hiera_hash("nginx::acmetool::certificates", {}),
    { notify => Exec[acmetool-reconcile] })

}

define eizo::nginx::acme::certificate($domains=[$title]) {
  file { "/var/lib/acme/desired/${title}":
    owner   => acmetool,
    require => User[acmetool],
    content => template("eizo/nginx/acme-cert.erb")
  }
}

