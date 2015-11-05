node /docker-centos.*/{

  group { 'jenkins':
    ensure => 'present',
    gid    => '120',
  }

  user { 'jenkins':
    ensure           => 'present',
    comment          => 'Jenkins,,,',
    gid              => '120',
    home             => '/var/jenkins_home',
    password         => '*',
    shell            => '/bin/bash',
    uid              => '120',
  }

  class { 'puppetdb::database::postgresql':
    listen_addresses => '*',
  } ->

  class {'docker':
    use_upstream_package_source => true,
    tcp_bind                    => 'tcp://0.0.0.0:4243',
    socket_bind                 => 'unix:///var/run/docker.sock',
  }

  docker::image{'centos':
    image_tag =>  ['centos7']
  }

  docker::image{'tfhartmann/puppetdb':
    image_tag =>  ['latest']
  }


  docker::image{'tfhartmann/puppetserver':
    image_tag =>  ['latest']
  }

  docker::image{'camptocamp/puppetboard':
    image_tag =>  ['latest']
  }

  docker::image{'msopenstack/sentinel-centos':
    image_tag =>  ['latest']
  }


  docker::run { 'puppetserver':
    image           => 'tfhartmann/puppetserver:latest',
    hostname        => 'puppet',
    ports           => ['8140:8140'],
  }
  docker::run { 'puppetdb':
    image           => 'tfhartmann/puppetdb:latest',
    hostname        => 'puppetdb',
    env             => ["DBHOST=${ipaddress}",'DBUSER=puppetdb','DBPASS=puppetdb'],
    ports           => ['8080:8080','8081:8081'],
  }

#  docker::run {'norman':
#    image           => 'msopenstack/sentinel-centos',
#    hostname        => 'norman',
#    command         => 'bin/bash',
#    ports           => ['22'],
#  }
  package{'curl':
    ensure => latest,
  } ->
  exec {'join-shipyard-swarm':
    command   => 'curl -sSL https://shipyard-project.com/deploy | ACTION=node DISCOVERY=etcd://10.1.1.51:4001 bash -s',
    logoutput => true,
    timeout   => 0,
    require   => Package['curl'],
  }
}
