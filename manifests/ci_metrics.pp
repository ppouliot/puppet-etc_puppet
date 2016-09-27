node /ci-metrics/ {
  package{['git','python2.7']:
    ensure => 'latest',
  } ->
  package{'python-pip':
    ensure => 'latest',
  } ->
  package{'ijson':
    ensure   => 'latest',
    provider => pip,
  } ->
  package{'python-django16':
    ensure   => 'latest',
  } ->
  package{'uwsgi':
    ensure   => 'latest',
  } ->
  class{'nginx':} -> 
  vcsrepo{'/CIMetricsTool':
    source   => 'https://github.com/openstack-hyper-v/CIMetricsAggregator',
    provider => 'git',
    ensure   => 'latest',
  } ->
  class{'::mysql::server':
    root_password => 'hard24get',
  } -> 
  mysql::db { 'cimetrics_db':
    user     => 'cimetrics',
    password => 'cimetrics',
    host     => 'localhost',
    grant    => ['CREATE','INSERT','SELECT','DELETE','UPDATE'],
  } ->
  class{'mysql::bindings':
    python_enable => 'true',
    php_enable    => 'true',
    perl_enable   => 'true',
  }


}
