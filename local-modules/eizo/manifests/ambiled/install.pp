class eizo::ambiled::install inherits eizo::ambiled {

  # Installation is manual.
  #
  # Compile with
  #  cmake -DENABLE_DISPMANX=OFF -DENABLE_SPIDEV=OFF -DENABLE_TINKERFORGE=OFF -DENABLE_V4L2=OFF ..
  #
  # Install this plugin for XBMC:
  #  wget https://github.com/poljvd/script.service.hyperion/archive/master.zip

  package { 'python-protobuf': ensure => installed}

  group { 'ambiled':
    ensure => present,
    system => true
  }
  ->
  user { 'ambiled':
    ensure => present,
    gid => 'ambiled',
    comment => 'ambiled user',
    home => "/var/run/ambiled",
    system => true,
    password => '*'
  }

}
