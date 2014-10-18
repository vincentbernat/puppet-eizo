class eizo::postfix::config inherits eizo::postfix {

  file { "/etc/postfix/main.cf":
    content => template("eizo/postfix/main.cf.erb"),
  }

  if ($key != undef) {
    file { "/etc/ssl/private/postfix.key":
      mode => 0600,
      content => "${key}",
    }
  }
  else {
    warning('no key present for postfix')
  }
  if ($cert != undef) {
    file { "/etc/ssl/postfix.pem":
      content => "${cert}",
    }
  }
  else {
    warning('no certificate present for postfix')
  }

  file { "/etc/mailname":
    content => template("eizo/postfix/mailname.erb"),
  }
  mailalias { 'root':
    target => "root@${origin}"
  }

}
