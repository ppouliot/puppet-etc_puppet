
node /^(docker[0-1]).openstack.tld/{
  package{'expect':
    ensure => latest,
  }

  class {'docker':
    tcp_bind    => 'tcp://0.0.0.0:4243',
#    socket_bind => 'unix:///var/run/docker.sock',
  }
#  class{'jenkins::slave':
#    masterurl => 'http:://moneypenny.openstack.tld:9000',
#    ui_user   => 'jenkins',
#    ui_pass   => 'jenkins',
#  }

  case $operatingsystem {
    'Ubuntu':{
      notice('Installing Ubuntu Trusty Container')

      docker::image {'ubuntu':
        image_tag =>  ['trusty']
      }
      docker::image {'base':
 
#        image_tag =>  ['trusty']
        ensure    =>  'absent',
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
