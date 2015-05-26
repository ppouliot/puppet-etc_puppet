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

  vcsrepo{'/usr/local/src/dockerfile-ubuntu_jenkins-slave':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/ppouliot/dockerfile-ubuntu_jenkins-slave.git'
  }

  case $operatingsystem {
    'Ubuntu':{
      notice('Installing Ubuntu Trusty Container')
      docker::image {'ubuntu':
        image_tag =>  ['trusty']
      }
      docker::image{'evarga/jenkins-slave':
        image_tag =>  ['latest']
      }
      docker::image{'csanchez/jenkins-swarm-slave':
        image_tag =>  ['latest']
      }
    }
    'Centos':{
      notice('Installing Centos 7 Container')
      docker::image {'centos':
        image_tag =>  ['centos7']
      }
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
