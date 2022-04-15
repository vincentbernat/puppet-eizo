class eizo::mysql($root, $root_password) {
  class {'::mysql::server':
    root_password => $root_password,
    remove_default_accounts => true,
    override_options => {
      mysqld => {
        datadir => $root
      }
    }
  }
}
