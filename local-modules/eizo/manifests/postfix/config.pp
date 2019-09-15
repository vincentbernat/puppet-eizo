class eizo::postfix::config inherits eizo::postfix {

  file { "/etc/postfix/main.cf":
    content => template("eizo/postfix/main.cf.erb"),
  }
  file { "/etc/postfix/master.cf":
    source => "/usr/share/postfix/master.cf.dist",
  }

  file { "/etc/mailname":
    content => template("eizo/postfix/mailname.erb"),
  }

  file { "/etc/postfix/sasl_passwd":
    content => "# Managed by Puppet.\n[${relay}]:587 ${relayauth}\n",
    mode    => "0640",
  }
  ~>
  exec { "postmap":
    command     => "/usr/sbin/postmap /etc/postfix/sasl_passwd",
    refreshonly => true
  }

}
