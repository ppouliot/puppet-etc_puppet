node 'jenkins-ovs.openstack.tld'{
  package{'mailutils':
    ensure => latest,
  }
  class {'jenkins':
    version            => latest,
    install_java       => true,
    configure_firewall => true,
    config_hash        => {
      'HTTP_PORT'      => {'value' => '9000' }
    },
  }
}
