node 'mysql-prod.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class{'mysql::server':
    root_password => 'hard24get',
#   overide_options => $overide_options,
  }
# $overide_options = {
#   'mysqld' => {
#     'expire_logs_days' => '30',
#     'innodb_file_per_table' => '1',
#     'default-storage-engine' => 'InnoDB',
#     'bind-address' => '0.0.0.0',
#     'max_connections' => '1500',
#    }
#  }

  class {'sensu':}
  class {'sensu_client_plugins': require => Class['sensu'],}
}
