class eizo::samba::config inherits eizo::samba {

  concat { "/etc/samba/smb.conf":
    ensure => present
  }
  concat::fragment { "smb-header.conf":
    target => "/etc/samba/smb.conf",
    source => "puppet:///modules/eizo/samba/smb.conf",
    order => '00'
  }
  $shares = hiera_hash('eizo::samba::shares')
  create_resources(
    'eizo::samba::share',
    $shares,
    {})

}
