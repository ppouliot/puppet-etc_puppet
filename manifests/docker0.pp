node /^(docker[0-1]).openstack.tld/{
  class {'docker':
    tcp_bind    => 'tcp://0.0.0.0:4243',
    socket_bind => 'unix:///var/run/docker.sock',
#    docker_users => [ 'jenkins','puppet' ],
  }
#  class{'jenkins::slave':
#    masterurl => 'http:://moneypenny.openstack.tld:9000',
#    ui_user   => 'jenkins',
#    ui_pass   => 'jenkins',
#  }

  vcsrepo{'/usr/local/src/dockerfile-sentinel-all':
    ensure   => latest,
    provider => git,
    source   => 'https://github.com/openstack-hyper-v/dockerfile-sentinel-all.git'
  }


  case $operatingsystem {
    'Ubuntu':{
      notice('This ubuntu container host executes Ubuntu Based container jobs')
      docker::image{'msopenstack/sentinel-debian':
        image_tag =>  ['latest']
      }
      docker::image{'msopenstack/sentinel-ubuntu_xenial':
        image_tag =>  ['latest']
      }
      docker::image{'msopenstack/sentinel-ubuntu_trusty':
        image_tag =>  ['latest']
      }
      docker::run { 'debian-minion':
        image       => 'msopenstack/sentinel-debian:latest',
        hostname    => 'debian-minion',
        command     => '/startup_slave.sh http://10.13.1.9:9000 debian_minion'
      }
      docker::run { 'trusty-minion':
        image       => 'msopenstack/sentinel-ubuntu_trusty:latest',
        hostname    => 'trusty-minion',
        command     => '/startup_slave.sh http://10.13.1.9:9000 trusty_minion'
      }
      docker::run { 'xenial-minion':
        image       => 'msopenstack/sentinel-ubuntu_xenial:latest',
        hostname    => 'xenial-minion',
        command     => '/startup_slave.sh http://10.13.1.9:9000 xenial_minion'
      }
    }
    'Centos':{
      notice('This centos container hosts runs a local postgresql server, operations production puppet infra containers, and executes centos based contianer jobs.')

#      class { 'puppetdb::database::postgresql':
#        listen_addresses => '*',
#      }

      docker::image{'centos':
        image_tag =>  ['centos7']
      }

      docker::image{'msopenstack/sentinel-centos':
        image_tag =>  ['latest']
      }
      docker::image{'msopenstack/sentinel-fedora':
        image_tag =>  ['latest']
      }
      docker::image{'msopenstack/sentinel-oraclelinux':
        image_tag =>  ['latest']
      }
#      docker::image{'tfhartmann/puppetdb':
#        image_tag =>  ['latest']
#      }

#      docker::image{'tfhartmann/puppetserver':
#        image_tag =>  ['latest']
#      }

#      docker::image{'camptocamp/puppetboard':
#        image_tag =>  ['latest']
#      }


     docker::run { 'centos-minion':
       image       => 'msopenstack/sentinel-centos:latest',
       hostname    => 'centos-minion',
       command     => '/startup_slave.sh http://10.13.1.9:9000 centos_minion'
     }
     docker::run { 'fedora-minion':
       image       => 'msopenstack/sentinel-fedora:latest',
       hostname    => 'fedora-minion',
       command     => '/startup_slave.sh http://10.13.1.9:9000 fedora_minion'
     }
     docker::run { 'oraclelinux-minion':
       image       => 'msopenstack/sentinel-oraclelinux:latest',
       hostname    => 'oraclelinux-minion',
       command     => '/startup_slave.sh http://10.13.1.9:9000 oraclelinux_minion'
     }
#      docker::run { 'puppetserver':
#        image           => 'tfhartmann/puppetserver:latest',
#        hostname        => 'puppet',
#        ports           => ['8140:8140'],
#      }
#      docker::run { 'puppetdb':
#        image           => 'tfhartmann/puppetdb:latest',
#        hostname        => 'puppetdb',
#        env             => ["DBHOST=${ipaddress}",'DBUSER=puppetdb','DBPASS=puppetdb'],
#        ports           => ['8080:8080','8081:8081'],
#      }

    }
    default:{
      warning("Unsupported ${operatingsystem}")
    }
  }

  file{'/root/docker_remove_images.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///extra_files/bin/docker_remove_images.sh',
  }
  file{'/root/docker_remove_stale_containers.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///extra_files/bin/docker_remove_stale_containers.sh',
  }

  file {'/root/join_shipyard.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///extra_files/bin/join_shipyard.sh',
  }



#  class {'sensu':}
#  class {'sensu_client_plugins': require => Class['sensu'],}
}

node default {
  case $virtual {
    'docker':{
      notice("${fqdn} virtualization is set to ${virtual}")
    }
    default:{
      warning("Warning virtualization: ${virtual} is incompatible with this class")
    }
  }
}
