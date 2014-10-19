class eizo::xbmc::config inherits eizo::xbmc {

  # Setup a custom EDID if one is provided
  if ($edid) {
    $blob = base64('decode', $edid['edid'])
    $output = $edid['output']

    file { '/lib/firmware/edid': ensure => directory }
    file { '/lib/firmware/edid/custom-edid.bin':
      ensure => present,
      content => $blob
    }
    ->
    file { '/etc/modprobe.d/custom-edid.conf':
      content => "options drm_kms_helper edid_firmware=${output}:edid/custom-edid.bin"
    }
    ->
    file { '/sys/modules/drm_kms_helper/parameters/edid_firmware':
      content => "${output}:edid/custom-edid.bin"
    }
  }

}
