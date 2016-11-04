node /vpn.*/ {
#  class {'basenode':}
#  class {'basenode::dhcp2static':}
  class {'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
  package {'bridge-utils':
    ensure => latest,
  }
  openvpn::server{'hypervci':
    country      => 'US',
    province     => 'MA',
    city         => 'Cambridge',
    organization => 'opentack.tld',
    email        => 'root@openstack.tld',
#    dev          => 'tap0',
    local        => $::ipaddress_br0,
#    proto        => 'tcp',
    server       => '10.253.253.0 255.255.255.0',
    push         => [
#                     'route 10.21.7.0 255.255.255.0 10.253.353.1',
                     'redirect-gateway def1 bypass-dhcp',
                     'dhcp-option DNS 10.21.7.1',
                     'dhcp-option DNS 8.8.8.8',
                     'dhcp-option DNS 8.8.4.4',
#                     'topology subnet'
                    ],
#    push         => ['route 10.21.7.0 255.255.255.0'],
  }

  firewall { '100 snat for network openvpn':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => "eth0",
    source   => '10.253.253.0/24',
    table    => 'nat',
  }
  firewall {'200 INPUT allow DNS':
    action => accept,
    proto  => 'udp',
    sport  => 'domain'
  }

  openvpn::client {'ppouliot':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'nmeier':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'trogers':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'habdi':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'cloudbase':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'apilotti':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'gsamfira':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'vbud':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'avladu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'cnesa':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'alinserdean':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'gloewen':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'seansp':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'lloydj':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'cbelu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'lpetrut':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'dinoc':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'ibalutoiu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'BArmstrong':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

# cgalan@cloudbasesolutions.com
  openvpn::client {'cgalan':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#nherciu@cloudbasesolutions.com
  openvpn::client {'nherciu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#abalutoiu@cloudbasesolutions.com
  openvpn::client {'abalutoiu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#abacos@cloudbasesolutions.com
  openvpn::client {'aBacos':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#rbuzatu@cloudbasesolutions.com
  openvpn::client {'rbuzatu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#v-tomazi@microsoft.com
  openvpn::client {'tomazi':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#qings@microsoft.com
#  openvpn::client {'qings':
#    server => 'hypervci',
#    remote_host => '64.119.130.115',
#  }

#msasci@microsoft.com
  openvpn::client {'msasci':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#alexng@microsoft.com
  openvpn::client {'alexng':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#vyadav@microsoft.com
  openvpn::client {'vyadav':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#sixiao@microsoft.com
  openvpn::client {'sixiao':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#v-chvale@microsoft.com
  openvpn::client {'v-chvale':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#Dorian Barboiu v-dobarb@microsoft.com
  openvpn::client {'v-dobarb':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#v-dopasl@microsoft.com
  openvpn::client {'v-dopasl':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#v-zsduda@microsoft.com
  openvpn::client {'v-zsduda':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
#v-sovin@microsoft.com
  openvpn::client {'v-sovin':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
# Adelina Tuvenie - atuvenie@cloudbasesolutions.com
  openvpn::client {'atuvenie':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#mgheorghe@cloudbasesolutions.com
# Mihai Gheorghe - mgheorghe@cloudbasesolutions.com
  openvpn::client {'mgheorghe':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

#acoman@cloudbasesolutions.com
# Alexandru Coman acoman@cloudbasesolutions.com
  openvpn::client {'acoman':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  } 

# Adrian Suhov v-adsuho@microsoft.com
  openvpn::client {'v-adsuho':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  } 

# Ovidiu Rusu 
# v-ovrusu@microsoft.com
  openvpn::client {'v-ovrusu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
# Paula Crismaru
# v-pacris@microsoft.com
  openvpn::client {'v-pacris':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
# mcostache@cloudbasesolutions.com
  openvpn::client {'mcostache':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }

# bcarpusor@cloudbasesolutions.com
  openvpn::client {'bcarpusor':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
# Matei Micu
# mmicu@cloudbasesolutions.com
  openvpn::client {'mmicu':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
# Iulia Toader? (v-sitoad@microsoft.com)
  openvpn::client {'itoader':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }
# Operations Callback
  openvpn::client {'operations_callback':
    server => 'hypervci',
    remote_host => '64.119.130.115',
  }


  class {'quagga':
    ospfd_source => 'puppet:///extra_files/ospfd.conf',
  }
#  file {'/etc/quagga/zebra.conf':
#    ensure  => file,
#    owner   => 'quagga',
#    group   => 'quagga',
#    mode    => '0640',
#    source  => 'puppet:///extra_files/zebra.conf',
#    notify  => Service['zebra'],
#    require => Class['quagga'],
#    before  => Service['zebra'],
#  }
}
