define eizo::samba::user($password) {
  exec { "smbpasswd-${name}":
    user    => 'root',
    group   => 'root',
    path    => ['/bin','/usr/bin'],
    unless  => "pdbedit -w -v -L ${name} |awk -F ' *: *' '(\$1 == \"NT hash\") {print \$2}' | grep -qFix $(printf \"${password}\" | iconv -f ASCII -t UTF-16LE | openssl md4 | awk '{print \$NF}')",
    command => "printf '%s\n%s\n' \"${password}\" \"${password}\" | smbpasswd -s -a ${name}",
  }
}
