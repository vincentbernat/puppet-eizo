class eizo::nfs {
  file { "/nfs":
    ensure => directory,
    # This seems quite dangerous, let's not try
    #recurse => true,
    #purge => true
  }

  concat { "/etc/exports":
    ensure => present,
    notify => Service[nfs-kernel-server]
  }
  $exports = lookup('eizo::nfs::exports', {merge=>hash})
  create_resources(
    'eizo::nfs::export',
    $exports,
    {})


  package { "nfs-kernel-server":
    ensure => installed
  }
  ->
  file_line { 'use fixed port for mountd':
    line    => 'RPCMOUNTDOPTS="--manage-gids -p 17865"',
    path    => '/etc/default/nfs-kernel-server',
    match   => "^RPCMOUNTDOPTS="
  }
  ~>
  service { "nfs-kernel-server":
    ensure  => running,
    restart => "systemctl reload ${name}"
  }
}
