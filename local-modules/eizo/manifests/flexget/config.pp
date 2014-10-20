class eizo::flexget::config inherits eizo::flexget {

  file { "${home}/.flexget":
    ensure => directory,
    owner => "flexget",
    group => "flexget"
  }
  file { "${home}/.flexget/config.yml":
    ensure => link,
    target => "/etc/flexget.yml"
  }
  file { "/etc/flexget.yml":
    source => "puppet:///modules/eizo/flexget/flexget.yml"
  }

}
