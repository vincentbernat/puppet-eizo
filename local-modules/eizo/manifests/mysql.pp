class eizo::mysql($root, $rootpassword) {
  class {'::mysql::server':
    root_password => $rootpassword,
    remove_default_accounts => true,
    override_options => {
      mysqld => {
        datadir => $root
      }
    }
  }
}
