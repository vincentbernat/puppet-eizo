class eizo::nginx {

  include ::nginx

  $confdir = hiera("nginx::config::conf_dir")

  file { "${confdir}/ssl":
    ensure => directory,
    mode => "0755"
  }

  create_resources(
    file,
    hiera_hash("eizo::nginx::certs", {}),
    { before => Class['::Nginx'],
      mode => "0600" })

}
