class eizo::munin {

  include ::munin::master
  include ::munin::node

  package { 'fcgiwrap':
    ensure => installed
  }

}
