class eizo::proftpd::user($dir, $keys) {

  file { "/etc/proftpd/users.keys/$name":
    content => template("eizo/proftpd/user.key.erb")
  }

}
