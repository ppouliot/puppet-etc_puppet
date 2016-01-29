node /shipyard.openstack.tld/{

  user { 'jenkins':
    ensure           => 'present',
    comment          => 'Jenkins,,,',
    gid              => '120',
    home             => '/var/jenkins_home',
    password         => '*',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
    uid              => '113',
  }
  group { 'jenkins':
    ensure => 'present',
    gid    => '120',
  }

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

  docker::image {'ubuntu':
    image_tag =>  ['trusty']
  }
# Official Jenkins LTS Docker Image
  docker::image{'library/jenkins':
    image_tag =>  ['latest']
  }

# Official Docker Registry Image
  docker::image{'library/registry':
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

  docker::run { 'jenkins-master':
    image           => 'library/jenkins:latest',
    ports           => ['9000:8080','50000:50000'],
    hostname        => 'jenkins-master',
    require         => User['jenkins'],
    restart_service => true,
  }
  docker::run { 'docker-registry':
    image           => 'library/registry:latest',
    hostname        => 'registry',
    ports           => ['8140:8140'],
  }
}
