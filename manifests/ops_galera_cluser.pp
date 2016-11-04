node 'c2-r13-u27-n1.openstack.tld',
     'c2-r13-u27-n2.openstack.tld',
     'c2-r13-u27-n3.openstack.tld',
     'c2-r13-u27-n4.openstack.tld'{

  class{'galera':
    galera_servers     => [
      '10.13.1.33',
      '10.13.1.34',
      '10.13.1.35',
      '10.13.1.36'],
    galera_master      => 'c2-r13-u27-n1.openstack.tld',
    local_ip           => $::ipaddress_enp1s0,
    bind_address       => $::ipaddress_enp1s0,
    vendor_type        => 'mariadb',
    root_password      => 'hard24get',
    status_password    => 'galera',
    override_options   => {
      'mysqld'         => {
        'bind_address' => '0.0.0.0',
      }
    }
  }

}
