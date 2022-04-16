class eizo::samba::config inherits eizo::samba {

  concat { "/etc/samba/smb.conf":
    ensure => present
  }
  concat::fragment { "smb-header.conf":
    target => "/etc/samba/smb.conf",
    source => "puppet:///modules/eizo/samba/smb.conf",
    order => '00'
  }

  $shares = lookup('eizo::samba::shares', {merge=>hash})
  create_resources(
    'eizo::samba::share',
    $shares,
    {})

  $users = lookup('eizo::samba::users', {merge=>hash})
  create_resources(
    'eizo::samba::user',
    $users,
    {})

}
