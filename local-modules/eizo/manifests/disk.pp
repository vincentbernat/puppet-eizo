class eizo::disk {

  # Enable noatime when needed
  exec { "partitions should be mounted with noatime":
    onlyif => "/bin/sed -n -e '
/^#/ !{
  # If extX and noatime, OK, check next line
  /\\([^ \\t]\\{1,\\}[ \\t]\\{1,\\}\\)\\{2\\}ext[234][ \\t]\\{1,\\}[^ \\t]*noatime/ b end
  # Otherwise, quit
  /\\([^ \\t]\\{1,\\}[ \\t]\\{1,\\}\\)\\{2\\}ext[234][ \\t]/ {
    p
    q 0
  }
}
:end
$ q 1
' /etc/fstab",
    command => "/bin/sed -i -e '
/^#/ !{
  # If extX and noatime, OK, do not modify
  /\\([^ \\t]\\{1,\\}[ \\t]\\{1,\\}\\)\\{2\\}ext[234][ \\t]\\{1,\\}[^ \\t]*noatime[^ \\t]*/ b
  # Otherwise, add noatime
  s/\\([^ \\t]\\{1,\\}[ \\t]\\{1,\\}\\)\\{2\\}ext[234][ \\t]\\{1,\\}[^ \\t]\\{1,\\}/&,noatime/
}
' /etc/fstab"
  }

  # RAID/LVM
  package { [ "lvm2", "mdadm" ]:
    ensure => present
  }

  # Schedule fstrim through cron
  cron { fstrim:
    command => "/sbin/fstrim -a",
    user => "root",
    hour => 3,
    minute => 7
  }

}
