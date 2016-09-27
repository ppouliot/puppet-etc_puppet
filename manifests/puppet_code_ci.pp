node 'c2-r13-u09' {
  notice("${fqdn} is puppet managed by moneypenny.openstack.tld")
  class { 'libvirt':
    qemu_vnc_listen => '0.0.0.0',
    qemu_vnc_sasl   => false,
    qemu_vnc_tls    => false,
  } ->

  class {'docker':
    tcp_bind        => 'tcp://0.0.0.0:4243',
    socket_bind     => 'unix:///var/run/docker.sock',
  } ->

  docker::image {'ubuntu':
    image_tag       =>  ['trusty','xenial']
  } ->

  docker::image{'msopenstack/sentinel-ubuntu':
    image_tag       =>  [latest]
  }

  package{[
    # Light UI for Mgmt
    'blackbox','tightvncserver','xterm','virt-manager',
    # httpasswd file management tools
    'apache2-utils',
    # Beaker Requrements
    'make','ruby-dev','libxml2-dev','libxslt1-dev','g++','zlib1g-dev',
    # Puppet Lint Syntax testing
    'puppet-lint',
  ]:
    ensure          => 'latest'
  } ->
  # Puppet-lint additional ruby gems
  package{[
    'puppet-lint-resource_reference_syntax',
    'puppet-lint-file_ensure-check',
    'puppet-lint-classes_and_types_beginning_with_digits-check',
    'puppet-lint-unquoted_string-check',
    'puppet-lint-appends-check',
    'puppet-lint-version_comparison-check',
    'puppet-lint-undef_in_function-check',
    'puppet-lint-trailing_comma-check',
    'puppet-lint-spaceship_operator_without_tag-check',
    'puppet-lint-leading_zero-check',
    'puppet-lint-empty_string-check',
    'puppet-lint-absolute_classname-check']:
    ensure          => absent,
    provider        => gem,
  }

  # Puppetlabs Beaker Acceptance Testing Tool
  package{[
    'beaker',
    'beaker-answers',
    'beaker-facter',
    'beaker-hiera',
    'beaker-hostgenerator',
    'beaker-librarian',
    'beaker-pe',
    'beaker-puppet_install_helper',
    'beaker-rspec',
    'beaker-testmode_switcher',
    'beaker-windows',
    'beaker_spec_helper',
    'simp-beaker-helpers']:
    ensure          => present,
    provider        => gem,
  }


  class {'jenkins':
    version                              => 'latest',
    lts                                  => false,
    executors                            => 8,
    install_java                         => true,
    configure_firewall                   => true,
    config_hash                          => {
      'HTTP_PORT'                        => {'value' => '9000' }
    },
    plugin_hash                          => {
      'antisamy-markup-formatter'        => { 'version' => 'latest' },
      'ansiolor'                         => { 'version' => 'latest' },
      'backup'                           => { 'version' => 'latest' },
      'build-alias-setter'               => { 'version' => 'latest' },
      'build-blocker-plugin'             => { 'version' => 'latest' },
      'build-cause-run-condition'        => { 'version' => 'latest' },
      'build-env-propagator'             => { 'version' => 'latest' },
      'build-environment'                => { 'version' => 'latest' },
      'build-failure-analyzer'           => { 'version' => 'latest' },
      'build-flow-extensions-plugin'     => { 'version' => 'latest' },
      'build-flow-plugin'                => { 'version' => 'latest' },
      'build-flow-test-aggregator'       => { 'version' => 'latest' },
      'build-flow-toolbox-plugin'        => { 'version' => 'latest' },
      'build-history-metrics-plugin'     => { 'version' => 'latest' },
      'build-keeper-plugin'              => { 'version' => 'latest' },
      'build-line'                       => { 'version' => 'latest' },
      'build-metrics'                    => { 'version' => 'latest' },
      'build-monitor-plugin'             => { 'version' => 'latest' },
      'build-name-setter'                => { 'version' => 'latest' },
      'build-pipeline-plugin'            => { 'version' => 'latest' },
      'build-publish'                    => { 'version' => 'latest' },
      'build-requester'                  => { 'version' => 'latest' },
      'build-timeout'                    => { 'version' => 'latest' },
      'build-timestamp'                    => { 'version' => 'latest' },
      'build-view-column'                => { 'version' => 'latest' },
      'built-on-column'                  => { 'version' => 'latest' },
      'credentials'                      => { 'version' => 'latest' },
      'cvs'                              => { 'version' => 'latest' },
      'compact-columns'                  => { 'version' => 'latest' },
      'configure-job-column-plugin'      => { 'version' => 'latest' },
      'console-column-plugin'            => { 'version' => 'latest' },
      'custom-job-icon'                  => { 'version' => 'latest' },
      'docker-workflow'                  => { 'version' => 'latest' },
      'docker-traceability'              => { 'version' => 'latest' },
      'docker-plugin'                    => { 'version' => 'latest' },
      'docker-custom-build-environment'  => { 'version' => 'latest' },
      'docker-commons'                   => { 'version' => 'latest' },
      'docker-build-step'                => { 'version' => 'latest' },
      'docker-build-publish'             => { 'version' => 'latest' },
      'gerrit'                           => { 'version' => 'latest' },
      'gerrit-trigger'                   => { 'version' => 'latest' },
      'github'                           => { 'version' => 'latest' },
      'github-api'                       => { 'version' => 'latest' },
      'git'                              => { 'version' => 'latest' },
      'git-changelog'                    => { 'version' => 'latest' },
      'git-client'                       => { 'version' => 'latest' },
      'git-chooser-alternative'          => { 'version' => 'latest' },
      'git-notes'                        => { 'version' => 'latest' },
      'git-parameter'                    => { 'version' => 'latest' },
      'git-tag-message'                  => { 'version' => 'latest' },
      'github-branch-source'             => { 'version' => 'latest' },
      'github-pullrequest'               => { 'version' => 'latest' },
      'global-build-stats'               => { 'version' => 'latest' },
      'global-post-script'               => { 'version' => 'latest' },
      'global-variable-string-parameter' => { 'version' => 'latest' },
      'javadoc'                          => { 'version' => 'latest' },
      'junit'                            => { 'version' => 'latest' },
      'job-restrictions'                 => { 'version' => 'latest' },
      'job-parameter-summary'            => { 'version' => 'latest' },
      'jobtemplates'                     => { 'version' => 'latest' },
      'jobtype-column'                   => { 'version' => 'latest' },
      'libvirt-slave'                    => { 'version' => 'latest' },
      'logging'                          => { 'version' => 'latest' },
      'mailer'                           => { 'version' => 'latest' },
      'matrix-auth'                      => { 'version' => 'latest' },
      'matrix-project'                   => { 'version' => 'latest' },
      'maven-plugin'                     => { 'version' => 'latest' },
      'mission-control-view'             => { 'version' => 'latest' },
      'modernstatus'                     => { 'version' => 'latest' },
      'multiple-scms'                    => { 'version' => 'latest' },
      'mysql-job-databases'              => { 'version' => 'latest' },
      'nested-view'                      => { 'version' => 'latest' },
      'network-monitor'                  => { 'version' => 'latest' },
      'openstack-cloud'                  => { 'version' => 'latest' },
      'pam-auth'                         => { 'version' => 'latest' },
      'parallel-test-executor'           => { 'version' => 'latest' },
      'parameterized-trigger'            => { 'version' => 'latest' },
      'powershell'                       => { 'version' => 'latest' },
      'port-allocator'                   => { 'version' => 'latest' },
      'puppet'                           => { 'version' => 'latest' },
      'postbuildscript'                  => { 'version' => 'latest' },
      'prereq-buildstep'                 => { 'version' => 'latest' },
      'project-build-times'              => { 'version' => 'latest' },
      'project-stats-plugin'             => { 'version' => 'latest' },
      'promoted-builds'                  => { 'version' => 'latest' },
      'python'                           => { 'version' => 'latest' },
      'saferestart'                      => { 'version' => 'latest' },
      'saltstack'                        => { 'version' => 'latest' },
      'scp'                              => { 'version' => 'latest' },
      'Sidebar'                          => { 'version' => 'latest' },
      'swarm'                            => { 'version' => 'latest' },
      'subversion'                       => { 'version' => 'latest' },
      'script-security'                  => { 'version' => 'latest' },
      'slave-prerequisites'              => { 'version' => 'latest' },
      'slave-proxy'                      => { 'version' => 'latest' },
      'slave-setup'                      => { 'version' => 'latest' },
      'slave-squatter'                   => { 'version' => 'latest' },
      'slave-status'                     => { 'version' => 'latest' },
      'slave-utilization-plugin'         => { 'version' => 'latest' },
      'stackhammer'                      => { 'version' => 'latest' },
      'started-by-envvar'                => { 'version' => 'latest' },
      'status-view'                      => { 'version' => 'latest' },
      'statusmonitor'                    => { 'version' => 'latest' },
      'systemloadaverage-monitor'        => { 'version' => 'latest' },
      'tfs'                              => { 'version' => 'latest' },
      'thinBackup'                       => { 'version' => 'latest' },
      'timestamper'                      => { 'version' => 'latest' },
      'token-macro'                      => { 'version' => 'latest' },
      'tracking-git'                     => { 'version' => 'latest' },
      'tracking-svn'                     => { 'version' => 'latest' },
      'translation'                      => { 'version' => 'latest' },
      'uptime'                           => { 'version' => 'latest' },
      'windows-azure-storage'            => { 'version' => 'latest' },
      'windows-exe-runner'               => { 'version' => 'latest' },
      'windows-slaves'                   => { 'version' => 'latest' },
      'vncrecorder'                      => { 'version' => 'latest' },
      'vncviewer'                        => { 'version' => 'latest' },
    },
  }

  git::config { 'user.name':
    value => 'hypervci',
  }

  git::config { 'user.email':
    value => 'hyper-v_ci@microsoft.com',
  }

  $gerrit_git_projects = '/usr/local/src'
  file { $gerrit_git_projects:
    ensure => directory,
  }

  Vcsrepo{
    group   => 'gerrit',
    owner   => 'gerrit',
    require => File[$gerrit_git_projects],
  }

  vcsrepo{"${gerrit_git_projects}/puppet-etc_puppet.git":
    source => 'https://github.com/ppouliot/puppet-etc_puppet',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-etc_puppetlabs.git":
    source => 'https://github.com/ppouliot/puppet-etc_puppetlabs',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-Puppetfile_Env.git":
    source => 'https://github.com/ppouliot/puppet-Puppetfile_Env',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-profiles.git":
    source => 'https://github.com/ppouliot/puppet-profiles',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-quartermaster.git":
    source => 'https://github.com/ppouliot/puppet-quartermaster',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-maas.git":
    source => 'https://github.com/ppouliot/puppet-maas',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-juju.git":
    source => 'https://github.com/ppouliot/puppet-juju',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-pf.git":
    source => 'https://github.com/ppouliot/puppet-pf',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/hiera-ipam.git":
    source => 'https://github.com/ppouliot/hiera-ipam',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_time.git":
    source => 'https://github.com/ppouliot/puppet-windows_time',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_containers.git":
    source => 'https://github.com/ppouliot/puppet-windows_containers',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_terminal_services.git":
    source => 'https://github.com/ppouliot/puppet-windows_terminal_services',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_platform_facts.git":
    source => 'https://github.com/ppouliot/puppet-windows_platform_facts',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_autologon.git":
    source => 'https://github.com/ppouliot/puppet-windows_autologon',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_shortcut.git":
    source => 'https://github.com/ppouliot/puppet-windows_shortcut',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_iscsi.git":
    source => 'https://github.com/ppouliot/puppet-windows_iscsi',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-dell_openmanage.git":
    source => 'https://github.com/openstack-hyper-v/puppet-dell_openmanage',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-ipam.git":
    source => 'https://github.com/openstack-hyper-v/puppet-ipam',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-packstack.git":
    source => 'https://github.com/openstack-hyper-v/puppet-packstack',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_openssl.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_openssl',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-manifests.git":
    source => 'https://github.com/openstack-hyper-v/puppet-manifests',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-cloudbase_prep.git":
    source => 'https://github.com/openstack-hyper-v/puppet-cloudbase_prep',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-iphawk.git":
    source => 'https://github.com/openstack-hyper-v/puppet-iphawk',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-openstack_hyper_v.git":
    source => 'https://github.com/openstack-hyper-v/puppet-openstack_hyper_v',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_common.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_common',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_python.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_python',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-sensu_server.git":
    source => 'https://github.com/openstack-hyper-v/puppet-sensu_server',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-sensu_client_plugins.git":
    source => 'https://github.com/openstack-hyper-v/puppet-sensu_client_plugins',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-jenkins_job_builder.git":
    source => 'https://github.com/openstack-hyper-v/puppet-jenkins_job_builder',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-osticket.git":
    source => 'https://github.com/openstack-hyper-v/puppet-osticket',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_freerdp.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_freerdp',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-openwsman.git":
    source => 'https://github.com/openstack-hyper-v/puppet-openwsman',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-basenode.git":
    source => 'https://github.com/openstack-hyper-v/puppet-basenode',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_clustering.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_clustering',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-hyper_v.git":
    source => 'https://github.com/openstack-hyper-v/puppet-hyper_v',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-redis.git":
    source => 'https://github.com/openstack-hyper-v/puppet-redis',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-mingw.git":
    source => 'https://github.com/openstack-hyper-v/puppet-mingw',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-visualcplusplus2008.git":
    source => 'https://github.com/openstack-hyper-v/puppet-visualcplusplus2008',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_sensu.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_sensu',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-ceilometer_hyper_v.git":
    source => 'https://github.com/openstack-hyper-v/puppet-ceilometer_hyper_v',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-nova_hyper_v.git":
    source => 'https://github.com/openstack-hyper-v/puppet-nova_hyper_v',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-cinder_hyper_v.git":
    source => 'https://github.com/openstack-hyper-v/puppet-cinder_hyper_v',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_git.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_git',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-petools.git":
    source => 'https://github.com/openstack-hyper-v/puppet-petools',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-network_mgmt.git":
    source => 'https://github.com/openstack-hyper-v/puppet-network_mgmt',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-devstack.git":
    source => 'https://github.com/openstack-hyper-v/puppet-devstack',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-gitlab.git":
    source => 'https://github.com/openstack-hyper-v/puppet-gitlab',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-gitlab_server.git":
    source => 'https://github.com/openstack-hyper-v/puppet-gitlab_server',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-docker.git":
    source => 'https://github.com/openstack-hyper-v/puppet-docker',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_java.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_java',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_7zip.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_7zip',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-windows_chrome.git":
    source => 'https://github.com/openstack-hyper-v/puppet-windows_chrome',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-winimagebuilder":
    source => 'https://github.com/ppouliot/puppet-winimagebuilder',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-notepadplusplus.git":
    source => 'https://github.com/openstack-hyper-v/puppet-notepadplusplus',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-visualcplusplus2012.git":
    source => 'https://github.com/openstack-hyper-v/puppet-visualcplusplus2012',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/puppet-visualcplusplus2010.git":
    source => 'https://github.com/openstack-hyper-v/puppet-visualcplusplus2010',
    provider => git,
    ensure   => 'latest',
  }
  vcsrepo{"${gerrit_git_projects}/dockerfile-sentinel-all.git":
    source => 'https://github.com/openstack-hyper-v/dockerfile-sentinel-all',
    provider => git,
    ensure   => 'latest',
  }
# Puppetlabs Beaker Testing Tools
  vcsrepo{'/opt/beaker':
    source   => 'https://github.com/puppetlabs/beaker',
    provider => git,
    ensure   => absent,
    revision => 'pe3.0',
  }
# Cloudbase Windows OpenStack Imaging Tools
  vcsrepo{'/opt/windows-openstack-imaging-tools':
    source   => 'https://github.com/cloudbase/windows-openstack-imaging-tools',
    provider => git,
    ensure   => present,
    revision => 'master',
  }
  # Beging Gerrit with Nginx & httppasswd
  class{'nginx': }
  httpauth { 'admin':
    file     => '/etc/nginx/gerrit.htpasswd',
    password => 'gerrit',
    realm => 'realm',
    mechanism => basic,
    ensure => present,
  }

  nginx::resource::vhost{ $ipaddress:
    proxy            => "http://${::ipaddress}:8080",
    proxy_set_header => [ 
      'X-Forward-For $remote_addr',
      'Host $host'
    ],
    auth_basic           => 'Gerrit Code Review',
    auth_basic_user_file => '/etc/nginx/gerrit.htpasswd',
  }

  file{[
    '/opt/gerrit',
    '/opt/gerrit/git']:
    ensure => directory,
    group  => 'gerrit',
    owner  => 'gerrit',
    mode   => '0755',
  } ->


  class{'staging':
    path  => '/opt/staging',
    owner => 'gerrit',
    group => 'gerrit',
  }

  staging::file{'gerrit-2.12.2.war':
    source => 'https://gerrit-releases.storage.googleapis.com/gerrit-2.12.2.war',
  }

  class{'gerrit':
    source            => '/opt/staging/gerrit-2.12.2.war',
    target            => '/opt/gerrit',
    auth_type         => 'http',
    database_backend  => 'mysql',
    database_hostname => '10.13.1.29',
    database_name     => 'puppetci_reviewdb',
    database_username => 'puppetci',
    database_password => 'hard24get',
    canonicalweburl   => "http://${::ipaddress}:8080/",
  }

  gerrit::repository{[
    'puppet-etc_puppet',
    'puppet-etc_puppetlabs',
    'puppet-Puppetfile_Env',
    'puppet-profiles',
    'puppet-quartermaster',
    'puppet-maas',
    'puppet-juju',
    'puppet-pf',
    'puppet-dell_openmanage',
    'puppet-ipam',
    'puppet-packstack',
    'puppet-windows_openssl',
    'puppet-manifests',
    'puppet-cloudbase_prep',
    'puppet-iphawk',
    'puppet-openstack_hyper_v',
    'puppet-windows_common',
    'puppet-windows_python',
    'puppet-sensu_server',
    'puppet-sensu_client_plugins',
    'puppet-jenkins_job_builder',
    'puppet-osticket',
    'puppet-windows_freerdp',
    'puppet-openwsman',
    'puppet-basenode',
    'puppet-windows_clustering',
    'puppet-hyper_v',
    'puppet-redis',
    'puppet-mingw',
    'puppet-visualcplusplus2008',
    'puppet-visualcplusplus2010',
    'puppet-visualcplusplus2012',
    'puppet-windows_sensu',
    'puppet-ceilometer_hyper_v',
    'puppet-nova_hyper_v',
    'puppet-cinder_hyper_v',
    'puppet-windows_git',
    'puppet-petools',
    'puppet-network_mgmt',
    'puppet-devstack',
    'puppet-gitlab',
    'puppet-gitlab_server',
    'puppet-docker',
    'puppet-windows_java',
    'puppet-windows_7zip',
    'puppet-windows_chrome',
    'puppet-windows_time',
    'puppet-windows_autologon',
    'puppet-windows_iscsi',
    'puppet-windows_shortcut',
    'puppet-windows_containers',
    'puppet-windows_platform_facts',
    'puppet-winimagebuilder',
    'puppet-notepadplusplus',
    'hiera-ipam',
    'dockerfile-sentinel-all']:
  } -> 
  exec{'gerrit_stop_reindex_reset_gerrit_ownership_and_start':
    command     => '/opt/gerrit/bin/gerrit.sh stop && /usr/bin/java -jar /opt/gerrit/bin/gerrit.war \'reindex\' && /bin/chown -R gerrit.gerrit /opt/gerrit && /opt/gerrit/bin/gerrit.sh start',
    cwd         => '/opt/gerrit',
    refreshonly => true,
  }
}
node 'eth0-c2-r13-u05' {
  if $::kernel == 'windows' {
    Package{ provider => chocolatey, }
  }
  class{'hyper_v':} ->
  class{'windows_containers':
    ensure => present,
  }
  windowsfeature{'NET-Framework-Core': }

# cygwin and cyg-get packages
  package { 'cygwin':
    ensure   => latest,
  } ->
  package { 'cyg-get':
    ensure   => latest,
  } ->
  exec{'cyg-get-cygwin_packages':
    command   => 'c:/programdata/chocolatey/bin/cyg-get.bat openssh wget rsync expect vim mail bind-utils xorg-server xinit xorg-docs',
    logoutput => true,
  }
  package {[
    'git',
    'wget',
    'curl',
    'rsync',
    'notepadplusplus',
    'putty',
    'winrar',
    'python',
    'python2',
    'google-chrome-x64',
    'Firefox',
    'jdk8',
    'jre8',
  ]:
    ensure => latest,
    provider => chocolatey,
  }
  windows_path{'C:\Program Files\Git\bin':
    ensure            => present,
  } ->
  file{'c:/programdata/src':
    ensure => directory,
  } ->
  vcsrepo{'c:/programdata/Invoke-DockerCI':
    source => 'https://github.com/jhowardmsft/Invoke-DockerCI',
    provider => git,
    ensure   => present,
    revision => 'master',
  }
  vcsrepo{'c:/programdata/puppet-windows_containers':
    source => 'https://github.com/jhowardmsft/Invoke-DockerCI',
    provider => git,
    ensure   => present,
    revision => 'master',
  }
  # Cloudbase Windows OpenStack Imaging Tools
  vcsrepo{'C:/staging/windows-openstack-imaging-tools':
    source   => 'https://github.com/cloudbase/windows-openstack-imaging-tools',
    provider => git,
    ensure   => present,
    revision => 'master',
  }
  file{'c:/programdata/windows_isos':
    ensure => directory,
  } ->

  exec{'get-windows-isos-from-quartermaster':
    command     => 'c:/programdata/chocolatey/bin/rsync.exe -avz -e ssh root@quartermaster.openstack.tld:/srv/install/miscrosoft/iso/*.iso .',
    cwd         => 'C:\programdata\windows_isos',
    path        => $path,
    logoutput   => true,
    timeout     => 0,
    refreshonly => true,
  }
}
node 'c2-r13-u13' {
  include chocolatey
  if $::kernel == 'windows' {
    Package{ provider => 'chocolatey' }
    class{'hyper_v':}
    class{'windows_autoupdate':
    # no_auto_update                      => 0,
      noAutoUpdate                        => 0,
    # au_options                          => 4,
      aUOptions                           => 4,
    # scheduled_install_day               => 0,
      scheduledInstallDay                 => 0,
    # no_auto_reboot_with_logged_on_users => 1,
      noAutoRebootWithLoggedOnUsers       => 1,
    } -> 
    windowsfeature{'NET-Framework-Core': }
  }
#  class{'petools':}
  # puppet & r10k
  package { 'puppet':
    ensure   => latest,
  } ->
  package {'r10k':
    ensure   => '2.1.1',
    provider => gem,
  }
  # Essential Windows Utils
  package {[
    'git',
    'wget',
    'curl',
    'rsync',
    'unzip',
    'notepadplusplus',
    'putty',
    'winrar',
    'VirtualCloneDrive',
    'python',
    'python2',
    'docker',
    'google-chrome-x64',
    'Firefox',
    'jdk8',
    ]:
    ensure   => latest,
  } ->
  windows_path {'C:\Program Files (x86)\PuppetLabs\puppet\bin':
    ensure => present,
  } ->
  windows_path {'C:\Program Files\Git\bin':
    ensure => present,
  } ->
  windows_path {'C:\Program Files (x86)\Java\jre1.8.0_77\bin':
    ensure => present,
  } ->
  windows_env{'JAVA_HOME=C:\Program Files (x86)\Java\jre1.8.0_77':}
  # Cloudbase Windows OpenStack Imaging Tools
  vcsrepo{'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\WinImageBuilder':
    source   => 'https://github.com/cloudbase/windows-openstack-imaging-tools',
    provider => git,
    ensure   => present,
    revision => 'master',
  } ->
  exec{'unblock-windows_openstack_imaging_tools':
    command   => 'dir * |Unblock-File',
    provider  => powershell,
    cwd       => 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\WinImageBuilder',
    logoutput => true,
  } ->
  exec{'unblock-windows_openstack_imaging_tools_bin':
    command   => 'dir * |Unblock-File',
    provider  => powershell,
    cwd       => 'C:\Windows\System32\WindowsPowerShell\v1.0\Modules\WinImageBuilder\bin',
    logoutput => true,
  }

  package { 'cygwin':
    ensure   => latest,
  } ->
  package { 'cyg-get':
    ensure   => latest,
  } ->
  exec{'cyg-get-cygwin_packages':
    command   => 'c:/programdata/chocolatey/bin/cyg-get.bat openssh wget rsync expect vim mail bind-utils xorg-server xinit xorg-docs',
    logoutput => true,
  }
  file{[
    'c:/programdata/windows_isos',
    'c:/programdata/cloud_images',
  ]:
    ensure => directory,
  }
  class{'staging':
    path    => 'C:/programdata/staging',
    owner   => 'Administrator',
    group   => 'Administrator',
    mode    => '0777',
    require => Package['unzip'],
  } -> 

  acl{'c:\ProgramData\staging':
    permissions => [
      { identity => 'Administrator', rights => ['full'] },
      { identity => 'Administrators', rights => ['full'] },
    ],
    require     => Class['staging'],
  }

  staging::file{'virtio-win.iso':
    source  => 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso',
    timeout => 0,
  }
  staging::file{'apc_hw05_aos640_rpdu2g640_bootmon108.exe':
    source => 'ftp://restrict:Kop$74!@ftp.apc.com/restricted/hardware/nmcard/firmware/rpdu2g/640/apc_hw05_aos640_rpdu2g640_bootmon108.exe',
  } ->
  exec{'extract_apc_apc_hw05_aos640_rpdu2g640_bootmon108.exe':
    command => 'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108.exe /auto',
    logoutput => true,
    creates => [
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\pc_hw05_aos_640.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\apc_hw05_bootmon_108.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\apc_hw05_rpdu2g_640.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\config.txt',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\FW_Upgrade_R2.exe',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\iplist.txt',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\winftp32.dll',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\winftp32.lib'],
  }

  file { 'c:\programdata\windows_isos\en_windows_8_1_enterprise_x64_dvd_2971902.iso':
    ensure  => 'file',
    content => '{md5}8e194185fcce4ea737f274ee9005ddf0',
    mode    => '0777',
  }
#  exec{'virtual_clone_drive_mount_windows_8.1_x64_291902.iso':
#    command    => '"C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\Daemon.exe" -mount 0 "c:\programdata\windows_isos\en_windows_8_1_enterprise_x64_dvd_2971902.iso"',
#    cwd        => 'c:\programdata\windows_isos',
#    logoutput  => true,
#    require    => Package['VirtualCloneDrive'],
#    refreshonly => true,
#  }

#  exec{'virtual_clone_drive_unmount':
#    command     => '"C:\Program Files (x86)\Elaborate Bytes\VirtualCloneDrive\Daemon.exe" -mount 0',
#    cwd         => 'c:\programdata\windows_isos',
#    logoutput   => true,
#    require     => Package['VirtualCloneDrive'],
#    refreshonly => true,
#  }


#  exec {'virtual_clone_drive_mount_windows_iso':
#    command => 'for %%f in (%1\*.iso) do "C:\Program Files(x86)\Elaborate Bytes\VirtualCloneDrive\daemon.exe" -mount 0 "%%f"',
#  }

  
}
