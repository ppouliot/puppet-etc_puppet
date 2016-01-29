node 'galera0.openstack.tld',
     'galera1.openstack.tld',
     'galera2.openstack.tld',
     'galera3.openstack.tld'{

  class{'galera':
    galera_servers                => ['10.13.1.26','10.13.1.27','10.13.1.28','10.13.1.29'],
    galera_master                 => 'galera0.openstack.tld',
    local_ip                      => $::ipaddress_eth0,
    bind_address                  => $::ipaddress_eth0,
    vendor_type                   => 'mariadb',
    root_password                 => 'hard24get',
    status_password               => 'galera',
    override_options              => {
      'mysqld'                    => {
        'bind_address'            => '0.0.0.0',
      }
    }
  }

}
