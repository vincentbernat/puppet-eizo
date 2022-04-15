define eizo::samba::share($password) {
  exec { "smbpasswd-${name}":
    user    => 'root',
    group   => 'root',
    path    => ['/bin','/usr/bin'],
    unless  => "printf ${pass} | iconv -f ASCII -t UTF-16LE | openssl md4 | awk '{print \"pdbedit -wL ${name} | grep -qi \"\$2}' | sh",
    command => "echo -ne \"${pass}\\n${pass}\\n\" | pdbedit -ta ${name}",
  }
}
