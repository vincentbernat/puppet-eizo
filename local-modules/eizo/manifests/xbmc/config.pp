class eizo::xbmc::config inherits eizo::xbmc {

  # Setup a custom EDID if one is provided
  if ($edid) {
    $blob = base64('decode', $edid['edid'])
    $output = $edid['output']

    file { '/lib/firmware/edid': ensure => directory }
    file { "/lib/firmware/edid/edid-${output}.bin":
      ensure => present,
      content => $blob
    }
    file { '/usr/local/bin/xbmc-edid':
      ensure => present,
      mode => 'a+x',
      source => "puppet:///modules/eizo/xbmc/xbmc-edid"
    }
  }

}
