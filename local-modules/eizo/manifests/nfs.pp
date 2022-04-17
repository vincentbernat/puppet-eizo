class eizo::nfs {
  package { "nfs-kernel-server":
    ensure => installed
  }
  exec { "nfs-exportfs":
    refreshonly => true,
    command => "/usr/sbin/exportfs -ra"
  }
  file { "/nfs":
    ensure => directory,
    # This seems quite dangerous, let's not try
    #recurse => true,
    #purge => true
  }

  concat { "/etc/exports":
    ensure => present
  }
  $exports = lookup('eizo::nfs::exports', {merge=>hash})
  create_resources(
    'eizo::nfs::export',
    $exports,
    {})
}
