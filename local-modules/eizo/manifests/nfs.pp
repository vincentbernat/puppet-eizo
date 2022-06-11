class eizo::nfs {
  file { "/nfs":
    ensure => directory,
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
  } ->
  cron { nfsexport:
    command => "/usr/sbin/exportfs -r",
    user => "root",
    minute => "*/10"
  }
}
