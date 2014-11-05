class eizo::munin {

  include ::munin::master
  include ::munin::node

  package { 'fcgi-wrap':
    ensure => installed
  }

}
