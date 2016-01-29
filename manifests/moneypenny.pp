node 'moneypenny.openstack.tld'{
  class{'profiles::tfs':}

  $dhcp_proxy_subnets = '# Additional Networks to listen to
dhcp-range=10.4.1.0,proxy
dhcp-range=10.5.1.0,proxy
dhcp-range=10.6.1.0,proxy
dhcp-range=10.7.1.0,proxy
dhcp-range=10.8.1.0,proxy
dhcp-range=10.9.1.0,proxy
dhcp-range=10.10.1.0,proxy
dhcp-range=10.11.1.0,proxy
dhcp-range=10.12.1.0,proxy
dhcp-range=10.13.1.0,proxy
dhcp-range=10.14.1.0,proxy
dhcp-range=10.15.1.0,proxy
dhcp-range=10.16.1.0,proxy
dhcp-range=10.17.1.0,proxy
dhcp-range=10.18.1.0,proxy
dhcp-range=10.19.1.0,proxy'

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
  manage_modulepath => false,
}

  class {'quartermaster':}
#  class {'quartermaster::dban':}

  package{'groovy':
    ensure => latest, 
  }


  ## Jenkins Server Settings
  class {'jenkins':
    version            => latest,
    install_java       => true,
    configure_firewall => true,
    config_hash        => {
      'HTTP_PORT'      => {'value' => '9000' }
    },
    ## Jenkins Plugins Added here
    ## TODO: Peter -- We need to add in the GitHub pull request builder plugin -- https://wiki.jenkins-ci.org/display/JENKINS/GitHub+pull+request+builder+plugin
    plugin_hash        => {
      'backup' => {},
      'build-node-column' => {},
      'build-view-column' => {},
      'built-on-column' => {},
      'compact-columns' => {},
      'configure-job-column-plugin' => {},
      'console-column-plugin' => {},
      'custom-job-icon' => {},
      'docker-plugin' => {},
      'docker-build-step' => {},
      'docker-build-publish' => {},
      'gerrit' => {},
      'gerrit-trigger' => {},
      'github' => {},
      'github-api' => {},
      'git' => {},
      'git-client' => {},
      'git-notes' => {},
      'git-parameter' => {},
      'git-tag-message' => {},
      'libvirt-slave' => {},
      'multiple-scms' => {},
      'nested-view' => {},
      'network-monitor' => {},
      'openstack-cloud' => {},
      'parallel-test-executor' => {},
      'parameterized-trigger' => {},
      'powershell' => {},
      'port-allocator' => {},
      'puppet' => {},
      'saferestart' => {},
      'saltstack' => {},
      'scp' => {},
      'swarm' => {},
      'slave-prerequisites' => {},
      'slave-proxy' => {},
      'slave-setup' => {},
      'slave-squatter' => {},
      'slave-status' => {},
      'stackhammer' => {},
      'started-by-envvar' => {},
      'status-view' => {},
      'statusmonitor' => {},
      'systemloadaverage-monitor' => {},
      'tfs' => {},
      'thinBackup' => {},
      'timestamper' => {},
      'token-macro' => {},
      'tracking-git' => {},
      'tracking-svn' => {},
      'uptime' => {},
      'windows-azure-storage' => {},
      'windows-exe-runner' => {},
      'windows-slaves' => {},
      'vncrecorder' => {},
      'vncviewer' => {},
    }
  }
  # jenkins application user configuration
  # This creates a jenkins user account
  jenkins::user {'jenkins':
    email    => "jenkins@${fqdn}",
    password => 'jenkins',
    public_key => 'ssh-dss AAAAB3NzaC1kc3MAAACBAKyFaUB2hgqiqlj9CMNN6k/SzBTWid07GOHAztQmgreAqdAH8J2Qae+Idq5YQJEZrLi4CCIHe0kPkqFveIZedELYgcLVqIFtVzypLCESySirBp3wM/o7gJgPraKOoJcfygC+WbAEpI12KL8e6DmpZmnLNicWgcFc3xUUC+MsvF8ZAAAAFQCANfgIk7cFFHkacEh3BXksJRGuNQAAAIEAoCOsEzH+0QYMq4Llc7p15pPc59nXIUd/BDUCu87diBqNvQcBPpZXBlmk9tJeEOytjbZs0PKm1izuYFbxISZl4SkcrsA/t3VhHaAXxQSthqfTNiQtqUvE2QDoi+u1LW2P/DnKCAO/oeWjMmNyUapv91ZY1iM6+kYMM7z1EMqs+t4AAACAei66Ns/cARNtYtFZzv1yamdfAInsZIQDvvfeF5PwXwqtFUKBP6o5+jxDQi/OWo/GuTP0wB76Fak2DoyP+jEdtn/m3t2aTmsjiKCvzyjlz3YiZNvCctZuatd9D0NfEj+8iLVovGx5jlz7e+nhxxzjwCggEbgHJh/NbRrFSW8DWbQ= root@norman',
  }
  # This should allow the jenkins user to work with local apache,
  # tftp, and other admin daemons that are running
  user { 'jenkins':
   groups => ['www-data', 'tftp', 'adm'],
  }

#  class {'jenkins_security':
#    require => Class['jenkins'],
#  }
  class{'jenkins_job_builder':
    require => Class['jenkins'],
  }
}
