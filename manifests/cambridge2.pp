node 'quartermaster.r4.c2.openstack.tld'{

  $dhcp_proxy_subnets = '# Additional Networks to listen to
dhcp-range=10.4.1.0,proxy
dhcp-range=10.5.0.0,proxy
dhcp-range=10.5.1.0,proxy
dhcp-range=10.6.0.0,proxy
dhcp-range=10.6.1.0,proxy
dhcp-range=10.7.0.0,proxy
dhcp-range=10.7.1.0,proxy'

  class {'quartermaster':}
}
