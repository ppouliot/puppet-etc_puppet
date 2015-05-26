node 'eth0-c2-r5-u39' {
  warning("** WARNING *** ${fqdn} is puppet Mananaged by the puppetmaster -> %% moneypenny.openstack.tld %%")
  file{'/etc/hostname':
    ensure  => file,
    content => 'maas0',
  }
  file{'/etc/resolv.conf':
    ensure  => file,
    content => '# PuppetManaged
nameserver 10.21.7.1
nameserver 10.21.7.2
nameserver 10.21.7.15
search openstack.tld',
  }
  file{'/etc/network/interfaces':
    ensure => file, 
    content => '# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
        address 10.5.1.39
        netmask 255.255.255.0
        gateway 10.5.1.254
        dns-domain openstack.tld
        dns-search openstack.tld
        dns-nameservers 10.21.7.1 10.21.7.2 4.2.2.1 4.2.2.2',
  }
  file {'/etc/hosts':
    ensure => file,
    content => '#Managed by Puppet
127.0.0.1	localhost 
10.5.1.39 maas0.openstack.tld	maas0
# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters',
  }
  class{'staging':
    path   => '/root',
    owner  => 'root',
    group  => 'root',
  }
  staging::file{'postinstall':
    source => 'http://10.4.1.39/bin/postinstall',
    notify => Exec['firstboot-exec']
  }
  exec{'firstboot-exec':
    command => '/usr/bin/nohup sh -x /root/postinstall &',
    require => File['/etc/resolv.conf',
                    '/etc/network/interfaces',
                    '/etc/hosts'], 
  }
}

node 'maas0.openstack.tld' {
  warning("** WARNING *** ${fqdn} is puppet Mananaged by the puppetmaster -> %% moneypenny.openstack.tld %%")
  class{'maas':
# Uncomment to use the ppa:maas-maintainers packages
    maas_maintainers_release => 'stable',
  } -> 
  class{'juju':} ->
  juju::generic_config{'root':}
}
node 'maas1.openstack.tld','maas2.openstack.tld','maas3.openstack.tld' {
  include apt
  apt::ppa{"ppa:maas-maintainers/stable":} ->
  package{'maas-cluster-controller':
    ensure => latest,
  } 
  file{'/var/lib/maas/secret':
    ensure => file,
    owner  => 'maas',
    group  => 'maas',
    mode   => '640',
    source => 'puppet://files/maas/secret',
  }
}
