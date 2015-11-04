node /hawk.openstack.tld/{
  class {'docker':
    tcp_bind    => 'tcp://0.0.0.0:4243',
    socket_bind => 'unix:///var/run/docker.sock',
#    docker_users => [ 'jenkins','puppet' ],
  } -> 
#  class{'jenkins::slave':
#    masterurl => 'http:://moneypenny.openstack.tld:9000',
#    ui_user   => 'jenkins',
#    ui_pass   => 'jenkins',
#  }

  vcsrepo{'/usr/local/src/dockerfile-ubuntu_jenkins-slave':
    ensure   => absent,
    provider => git,
    source   => 'https://github.com/ppouliot/dockerfile-ubuntu_jenkins-slave.git'
  }
  vcsrepo{'/usr/local/src/dockerfile-sentinel-all':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/openstack-hyper-v/dockerfile-sentinel-all.git'
  }


  notice('Installing Centos 7 Container')
  docker::image {'centos':
    image_tag =>  ['centos7']
  }
  docker::image{'msopenstack/sentinel-centos':
    image_tag =>  ['latest']
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
