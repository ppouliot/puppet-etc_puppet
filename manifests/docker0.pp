
node /^(docker[0-1]).openstack.tld/{

  class {'docker':
    tcp_bind    => "tcp://${::ipaddress}:4243",
    socket_bind => 'unix:///var/run/docker.sock',
  }

  case $operatingsystem {
    'Ubuntu':{
      notice('Installing Ubuntu Trusty Container')

      docker::image {'ubuntu':
        image_tag =>  ['trusty']
      }
    
    }
    'Centos':{
      docker::image {'centos':
        image_tag =>  ['centos7']
      }
    }
    default:{
      warning("Unsupported ${operatingsystem}")
    }
  }
#  class {'sensu':}
#  class {'sensu_client_plugins': require => Class['sensu'],}
}
