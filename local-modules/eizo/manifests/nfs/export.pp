define eizo::nfs::export($path, $uid, $gid, $hosts) {
  concat::fragment { "nfs-exports-${name}":
    target => "/etc/exports",
    content => template("eizo/nfs/export.erb"),
    order => '10',
    notify => Exec[nfs-exportfs]
  }
  file { "/nfs/${name}":
    ensure => "directory",
    owner => $uid,
    group => $gid
  } ->
  mount { "/nfs/${name}":
    ensure => "mounted",
    device => $path,
    fstype => "none",
    options => "rw,bind"
  }
}
