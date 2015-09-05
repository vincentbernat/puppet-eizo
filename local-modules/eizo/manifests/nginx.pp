class eizo::nginx {

  include ::nginx

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
      command => "t=$(mktemp -p $(dirname ${path})) && curl -s -o \$t ${url} && mv \$t ${path}"
    }
  }
}
