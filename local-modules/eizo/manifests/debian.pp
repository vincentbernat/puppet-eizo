class eizo::debian(
  $packages = []) {

  class { "apt":
    purge => {
      "sources.list"   => true,
      "sources.list.d" => true,
      "preferences.d"  => true
    }
  }

  package { $packages: ensure => installed }

  package { "apt-transport-https": ensure => installed }
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

  apt::source { "trixie":
    location          => 'http://ftp.fr.debian.org/debian',
    release           => 'trixie',
    repos             => 'main contrib non-free-firmware',
  }
  apt::source { "trixie-security":
    location => 'http://security.debian.org/debian-security',
    release  => 'trixie-security',
    repos    => 'main contrib non-free-firmware',
  }
  apt::source { "trixie-backports":
    location          => 'http://ftp.fr.debian.org/debian',
    release           => 'trixie-backports',
    repos             => 'main contrib',
  }

}
