node 'moneypenny.openstack.tld'{

  $dhcp_proxy_subnets = '# Additional Networks to listen to
dhcp-range=10.4.1.0,proxy
dhcp-range=10.5.1.0,proxy
dhcp-range=10.6.1.0,proxy
dhcp-range=10.7.1.0,proxy'

class { 'r10k':
  version           => latest,
  sources           => {
    'puppetfiles' => {
      'remote'  => 'https://github.com/ppouliot/puppet-Puppetfile_Env.git',
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    },
    'hiera' => {
      'remote'  => 'https://github.com/ppouliot/puppet-hieradata.git',
      'basedir' => "${::settings::confdir}/hiera",
      'prefix'  => false,
    },
  },
  purgedirs         => ["${::settings::confdir}/environments"],
  manage_modulepath => false,
}

  class {'quartermaster':}
  class {'jenkins':
    version            => 'latest',
    install_java       => true,
    repo               => true,
    configure_firewall => true,
    config_hash        => {
      'HTTP_PORT'      => {'value' => '9000' }
    }
  }
  jenkins::plugin{'puppet':}
  jenkins::plugin{'docker-plugin':}
  jenkins::plugin{'docker-build-step':}
  jenkins::plugin{'docker-build-publish':}

}
