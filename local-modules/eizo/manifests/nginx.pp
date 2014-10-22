class eizo::nginx {

  include ::nginx

  file { "/etc/nginx/ssl":
    ensure => directory,
    mode => "0755"
  }

  create_resources(
    file,
    hiera_hash("eizo::nginx::certs", {}),
    { before => Class['::Nginx'],
      mode => "0600" })

}
