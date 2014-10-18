class eizo::debian($packages = {}) {

  stage { 'apt-configuration':
    before => Stage['main']
  }

  class { "apt":
    purge_sources_list   => true,
    purge_sources_list_d => true,
    purge_preferences_d  => true,
    stage => 'apt-configuration'
  }

  package { "aptitude": ensure => installed } ->
  file { "/etc/apt/apt.conf.d/25aptitude":
    source => "puppet:///modules/eizo/debian/apt/25aptitude"
  }

  file { "/etc/apt/apt.conf.d/02periodic":
    source => "puppet:///modules/eizo/debian/apt/02periodic"
  }
  file { "/etc/apt/apt.conf.d/10disable-pdiff":
    source => "puppet:///modules/eizo/debian/apt/10disable-pdiff"
  }
  file { "/etc/apt/apt.conf.d/99translations":
    source => "puppet:///modules/eizo/debian/apt/99translations"
  }

  apt::source { "wheezy":
    location          => 'http://http.debian.net/debian/',
    release           => 'wheezy',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring debian-archive-keyring',
    include_src       => false
  }

  apt::source { "wheezy-backports":
    location          => 'http://http.debian.net/debian/',
    release           => 'wheezy-backports',
    repos             => 'main contrib non-free',
    required_packages => 'debian-keyring debian-archive-keyring',
    include_src       => false
  }

  create_resources(package, $packages, { ensure => present })

}
