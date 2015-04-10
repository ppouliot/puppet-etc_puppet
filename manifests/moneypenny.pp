node 'moneypenny.openstack.tld'{
  package{[
    'expect','screen','minicom','ipmitool','openipmi']:
    ensure => latest,
  }

  $dhcp_proxy_subnets = '# Additional Networks to listen to
dhcp-range=10.4.1.0,proxy
dhcp-range=10.5.1.0,proxy
dhcp-range=10.6.1.0,proxy
dhcp-range=10.7.1.0,proxy'

class { 'r10k':
  version           => latest,
  sources           => {
    'puppetfiles'   => {
      'remote'      => 'https://github.com/ppouliot/puppet-Puppetfile_Env.git',
      'basedir'     => "${::settings::confdir}/environments",
      'prefix'      => false,
    },
    'hiera'         => {
      'remote'      => 'https://github.com/ppouliot/puppet-hieradata.git',
      'basedir'     => "${::settings::confdir}/hiera",
      'prefix'      => false,
    },
  },
  purgedirs         => ["${::settings::confdir}/environments"],
  manage_modulepath => false,
}

  class {'quartermaster':}

  ## Jenkins Server Settings
  class {'jenkins':
    version            => 'latest',
    lts                => false,
    install_java       => true,
    repo               => true,
    configure_firewall => true,
    config_hash        => {
      'HTTP_PORT'      => {'value' => '9000' }
    },
    ## Jenkins Plugins Added here
    plugin_hash        => {
      'parameterized-trigger' => {},
      'multiple-scms' => {},
      'git-client' => {},
      'token-macro' => {},
      'puppet' => {},
      'docker-plugin' => {},
      'docker-build-step' => {},
      'docker-build-publish' => {},
      'configure-job-column-plugin' => {},
      'thinBackup' => {},
      'backup' => {},
      'build-node-column' => {},
      'build-view-column' => {},
      'built-on-column' => {},
      'compact-columns' => {},
      'console-column-plugin' => {},
      'custom-job-icon' => {},
      'tfs' => {},
      'github' => {},
      'github-api' => {},
      'git' => {},
      'git-client' => {},
      'git-notes' => {},
      'git-parameter' => {},
      'git-tag-message' => {},
      'timestamper' => {}
    }
  }


  jenkins::user {'jenkins':
    email    => "jenkins@${fqdn}",
    password => 'jenkins',
    public_key => 'ssh-dss AAAAB3NzaC1kc3MAAACBAKyFaUB2hgqiqlj9CMNN6k/SzBTWid07GOHAztQmgreAqdAH8J2Qae+Idq5YQJEZrLi4CCIHe0kPkqFveIZedELYgcLVqIFtVzypLCESySirBp3wM/o7gJgPraKOoJcfygC+WbAEpI12KL8e6DmpZmnLNicWgcFc3xUUC+MsvF8ZAAAAFQCANfgIk7cFFHkacEh3BXksJRGuNQAAAIEAoCOsEzH+0QYMq4Llc7p15pPc59nXIUd/BDUCu87diBqNvQcBPpZXBlmk9tJeEOytjbZs0PKm1izuYFbxISZl4SkcrsA/t3VhHaAXxQSthqfTNiQtqUvE2QDoi+u1LW2P/DnKCAO/oeWjMmNyUapv91ZY1iM6+kYMM7z1EMqs+t4AAACAei66Ns/cARNtYtFZzv1yamdfAInsZIQDvvfeF5PwXwqtFUKBP6o5+jxDQi/OWo/GuTP0wB76Fak2DoyP+jEdtn/m3t2aTmsjiKCvzyjlz3YiZNvCctZuatd9D0NfEj+8iLVovGx5jlz7e+nhxxzjwCggEbgHJh/NbRrFSW8DWbQ= root@norman',
  }

#  class {'jenkins_security':
#    require => Class['jenkins'],
#  }
  class{'jenkins_job_builder':
    require => Class['jenkins'],
  }
}
