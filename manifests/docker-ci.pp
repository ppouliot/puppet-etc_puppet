node /docker-ci.pouliot.net/{

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
    use_upstream_package_source => true,
    tcp_bind                    => 'tcp://0.0.0.0:4243',
    socket_bind                 => 'unix:///var/run/docker.sock',
  }
  docker::image {'ubuntu':
    image_tag =>  ['trusty']
  }
  docker::image{'jenkinsci/jenkins':
    image_tag =>  ['latest']
  }

  docker::image{'msopenstack/sentinel-ubuntu':
    image_tag =>  ['latest']
  }
  docker::run { 'jenkins':
    image           => 'jenkinsci/jenkins:latest',
    ports           => ['9000:8080','50000:50000'],
    hostname        => 'jenkins',
    require         => User['jenkins'],
    restart_service => true,
  }

#  docker::run { 'shipyard-rethinkdb':
#    image           => 'shipyard/rethinkdb:latest',
#    hostname        => 'shipyard-rethinkdb',
#    restart_service => true,
#  } ->

#  docker::run { 'shipyard-discovery':
#    image           => 'microbox/etcd:latest',
#    command         => "-name discovery -addr ${ipaddress_eth0}:4001 -peer-addr ${ipaddress_eth0}:7001",
#    hostname        => 'shipyard-discovery',
#    ports           => ['4001:4001','7001:7001'],
#    restart_service => true,
#  } ->

#  docker::run { 'shipyard-proxy':
#    image           => 'ehazlett/docker-proxy:latest',
#    hostname        => 'shipyard-proxy',
#   ports           => ['2375:2375'],
#    expose          => ['2375'],
#    volumes         => ['/var/run/docker.sock','/var/run/docker.sock'],
#    volumes         => ['/var/run/docker.sock'],
#    restart_service => true,
#  } -> 

#  docker::run { 'shipyard-swarm-manager':
#    image           => 'swarm:latest',
#    command         => "m --replication --addr ${ipaddress_eth0}:3375 --host tcp://0.0.0.0:3375 etcd://discovery:4001",
#    links           => ['shipyard-discovery:discovery'],
#    hostname        => 'shipyard-swarm-manager',
#    restart_service => true,
#  } ->

#  docker::run { 'shipyard-swarm-agent':
#    image           => 'swarm:latest',
#    command         => "j --addr ${ipaddress_eth0}:2375 etcd://discovery:4001",
#    links           => ['shipyard-discovery:discovery'],
#    hostname        => 'shipyard-swarm-agent',
#    restart_service => true,
#  } ->

#  docker::run { 'shipyard-controller':
#    image           => 'shipyard/shipyard:latest',
#    command         => 'server --listen :8080 -d tcp://swarm:3375',
#    links           => ['shipyard-rethinkdb:rethinkdb',
#                        'shipyard-swarm-manager:swarm'],
#    hostname        => 'shipyard-controller',
#    ports           => ['8080:8080'],
#    restart_service => true,
#  }
}
