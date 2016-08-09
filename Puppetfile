# Warning: This file is managed by puppet.
# 
# Please look at the http://github.com/ppouliot/puppet-Puppetfile_Env  for information
#
#
# This Logic was provided by bodepd

# the account where the Openstack modules should come from
#
#

# this modulefile has been configured to use two sets of repos.
# the account where the Openstack modules should come from
#
# this file also accepts a few environment variables
#
git_protocol=ENV['git_protocol'] || 'git'

#
# this modulefile has been configured to use two sets of repos.
# The downstream repos that Cisco has forked, or the upstream repos
# that they are derived from (and should be maintained in sync with)
#

#
# this is just targeting the upstream stackforge modules
# right now, and the logic for using downstream does not
# work yet
#

if ENV['repos_to_use']  == 'downstream'
  # this assumes downstream which is the Cisco branches
  branch_name               = 'origin/havana'
  openstack_module_branch   = branch_name
  openstack_module_account  = 'CiscoSystems'
  puppetlabs_module_account = 'CiscoSystems'
  # manifests
  user_name = 'CiscoSystems'
  release = 'havana'
  manifest_branch = 'origin/multi-node'
else
  # use the upstream modules where they exist
  branch_name               = 'origin/mitaka'
  openstack_module_branch   = 'master'
  openstack_module_account  = 'stackforge'
  puppetlabs_module_account = 'puppetlabs'
  # manifests
  user_name = 'primeministerp'
  release = 'mitaka'
  manifest_branch = 'origin/master'
end

base_url     = "#{git_protocol}://github.com"
ssh_url      = "#{git_protocol}://github.com"
branch_name  = 'origin/mitaka'

###### Installer Manifests Example ##############
#mod 'manifests', :git => "#{base_url}/#{user_name}/#{release}-manifests", :ref => "#{manifest_branch}"

##### Puppet Labs modules #####

openstack_repo_prefix = "#{base_url}/#{openstack_module_account}/puppet"
mod 'hiera',        :git => "#{base_url}/hunner/puppet-hiera", :tag => '2.0.1' #PRODUCTION #SUPPORTED
mod 'stdlib',          :git => "#{base_url}/puppetlabs/puppetlabs-stdlib",          :tag => '4.12.0' #SUPPORTED
mod 'vcsrepo',         :git => "#{base_url}/puppetlabs/puppetlabs-vcsrepo",         :tag => '1.3.2' #SUPPORTED
mod 'apt',             :git => "#{base_url}/puppetlabs/puppetlabs-apt",             :tag => '2.2.2' #SUPPORTED
mod 'concat',          :git => "#{base_url}/puppetlabs/puppetlabs-concat",          :tag => '2.2.0' #SUPPORTED
mod 'motd',            :git => "#{base_url}/puppetlabs/puppetlabs-motd",            :tag => '1.4.0' #SUPPORTED
mod 'firewall',        :git => "#{base_url}/puppetlabs/puppetlabs-firewall",        :tag => '1.8.1' #SUPPORTED
mod 'apache',          :git => "#{base_url}/puppetlabs/puppetlabs-apache",          :tag => '1.10.0' #SUPPORTED
mod 'inifile',         :git => "#{base_url}/puppetlabs/puppetlabs-inifile",         :tag => '1.5.0' #SUPPORTED
mod 'mysql',           :git => "#{base_url}/puppetlabs/puppetlabs-mysql",           :tag => '3.8.0' #SUPPORTED
mod 'postgresql',      :git => "#{base_url}/puppetlabs/puppetlabs-postgresql",      :tag => '4.8.0' #SUPPORTED
mod 'ntp',             :git => "#{base_url}/puppetlabs/puppetlabs-ntp",             :tag => '4.2.0' #SUPPORTED
mod 'java',            :git => "#{base_url}/puppetlabs/puppetlabs-java",            :tag => '1.6.0' #SUPPORTED
mod 'haproxy',         :git => "#{base_url}/puppetlabs/puppetlabs-haproxy",         :tag => '1.5.0' #SUPPORTED
mod 'java_ks',         :git => "#{base_url}/puppetlabs/puppetlabs-java_ks",         :tag => '1.4.1' #SUPPORTED
mod 'tomcat',          :git => "#{base_url}/puppetlabs/puppetlabs-tomcat",          :tag => '1.4.1' #SUPPORTED
mod 'powershell',      :git => "#{base_url}/puppetlabs/puppetlabs-powershell",      :tag => '2.0.2' #SUPPORTED #WINDOWS
mod 'registry',        :git => "#{base_url}/puppetlabs/puppetlabs-registry",        :tag => '1.1.3' #SUPPORTED #WINDOWS
mod 'reboot',          :git => "#{base_url}/puppetlabs/puppetlabs-reboot",          :tag => '1.2.1' #SUPPORTED #WINDOWS
mod 'acl',             :git => "#{base_url}/puppetlabs/puppetlabs-acl",             :tag => '1.1.2' #SUPPORTED #WINDOWS
mod 'aws',             :git => "#{base_url}/puppetlabs/puppetlabs-aws",             :tag => '1.4.0' #SUPPORTED
mod 'tagmail',         :git => "#{base_url}/puppetlabs/puppetlabs-tagmail",         :tag => '2.1.1' #SUPPORTED
mod 'docker_platform', :git => "#{base_url}/puppetlabs/puppetlabs-docker_platform", :tag => '2.0.0' #SUPPORTED
mod 'puppet_agent',    :git => "#{base_url}/puppetlabs/puppetlabs-puppet_agent",    :tag => '1.0.0' #SUPPORTED
mod 'wsus_client',     :git => "#{base_url}/puppetlabs/puppetlabs-wsus_client",     :tag => '1.0.2' #SUPPORTED #WINDOWS
mod 'azure',           :git => "#{base_url}/puppetlabs/puppetlabs-azure",           :tag => '1.0.3' #SUPPORTED #WINDOWS
mod 'dsc',             :git => "#{base_url}/puppetlabs/puppetlabs-dsc",             :tag => '1.0.1' #SUPPORTED #WINDOWS
mod 'accounts',        :git => "#{base_url}/puppetlabs/puppetlabs-accounts",        :tag => '1.0.0' #SUPPORTED #WINDOWS
mod 'puppet_agent',    :git => "#{base_url}/puppetlabs/puppetlabs-puppet_agent",    :tag => '1.2.0' #SUPPORTED
mod 'netdev_stdlib_eos', :git => "#{base_url}/arista-eosplus/puppet-netdev",    :tag => 'v1.1.1' #SUPPORTED
#mod 'ciscopuppet', :git => "#{base_url}/cisco/cisco-network-puppet-module",    :tag => 'v1.3.2' #SUPPORTED
#mod 'ciscopuppet',     :git => "#{base_url}/cisco/cisco-network-puppet-module",     :tag => 'v1.3.2' #SUPPORTED
#mod 'f5',              :git => "#{base_url}/puppetlabs/puppetlabs-f5",              :tag => '1.0.0' #SUPPORTED #WINDOWS
# mod 'sqlserver',       :git => "#{base_url}/puppetlabs/puppetlabs-sqlserver",       :tag => '1.0.0' #SUPPORTED #WINDOWS
mod 'sensu',         :git => "#{base_url}/sensu/sensu-puppet",         :tag => 'v1.5.5'  #APPROVED
mod 'epel',          :git => "#{base_url}/stahnma/puppet-module-epel", :tag => '1.2.2' #APPROVED
mod 'python',        :git => "#{base_url}/stankevich/puppet-python",   :tag => '1.11.0'      #APPROVED
mod 'logrotate',     :git => "#{base_url}/rodjek/puppet-logrotate",    :tag => 'v1.0.2'       #APPROVED
mod 'gitlab',        :git => "#{base_url}/vshn/puppet-gitlab",         :tag => 'v1.0.2'       #APPROVED
mod 'elasticsearch',     :git => "#{base_url}/elastic/puppet-elasticsearch", :tag => '0.9.9' #APPROVED
mod 'erlang',        :git => "#{base_url}/garethr/garethr-erlang"                   #APPROVED
mod 'docker',        :git => "#{base_url}/garethr/garethr-docker", :tag => 'v5.1.0' #APPROVED
mod 'augeasproviders',          :git => "#{base_url}/hercules-team/augeasproviders",                :tag => 'v2.1.3' #APPROVED
mod 'augeasproviders_shellvar',   :git => "#{base_url}/hercules-team/augeasproviders_shellvar",     :tag => '2.2.1' #APPROVED
mod 'augeasproviders_sysctl',     :git => "#{base_url}/hercules-team/augeasproviders_sysctl",       :tag => '2.0.2' #APPROVED
mod 'augeasproviders_ssh',        :git => "#{base_url}/hercules-team/augeasproviders_ssh",          :tag => '2.5.0' #APPROVED
mod 'augeasproviders_pam',        :git => "#{base_url}/hercules-team/augeasproviders_pam",          :tag => '2.1.0' #APPROVED
mod 'augeasproviders_mounttab',   :git => "#{base_url}/hercules-team/augeasproviders_mounttab",     :tag => '2.0.1' #APPROVED
mod 'augeasproviders_grub',       :git => "#{base_url}/hercules-team/augeasproviders_grub",         :tag => '2.0.1' #APPROVED
mod 'augeasproviders_base',       :git => "#{base_url}/hercules-team/augeasproviders_base",         :tag => '2.0.1' #APPROVED
mod 'augeasproviders_core',       :git => "#{base_url}/hercules-team/augeasproviders_core",         :tag => '2.1.2' #APPROVED
mod 'augeasproviders_nagios',     :git => "#{base_url}/hercules-team/augeasproviders_nagios",       :tag => '2.0.1' #APPROVED
mod 'augeasproviders_apache',     :git => "#{base_url}/hercules-team/augeasproviders_apache",       :tag => '2.0.1' #APPROVED
mod 'augeasproviders_syslog',     :git => "#{base_url}/hercules-team/augeasproviders_syslog",       :tag => '2.1.1' #APPROVED
mod 'augeasproviders_postgresql', :git => "#{base_url}/hercules-team/augeasproviders_postgresql",   :tag => '2.0.3' #APPROVED
mod 'augeasproviders_puppet',     :git => "#{base_url}/hercules-team/augeasproviders_puppet",       :tag => '2.1.0' #APPROVED
mod 'jenkins',         :git => "#{base_url}/jenkinsci/puppet-jenkins", :tag => 'v1.6.1'  #APPROVED
mod 'wget',       :git => "#{base_url}/maestrodev/puppet-wget",       :tag => 'v1.7.3'  #APPROVED 
mod 'python',        :git => "#{base_url}/stankevich/puppet-python", :tag => '1.9.4' #APPROVED
mod 'r10k',         :git => "#{base_url}/acidprime/r10k", :tag => 'v3.2.0' #APPROVED
#mod 'staging',          :git => "#{base_url}/nanliu/puppet-staging",          :tag => '1.0.4' #APPROVED
#mod 'collectd', :git => "#{base_url}/pdxcat/puppet-module-collectd",   :tag => 'v3.3.0' #APPROVED Moved to puppet-community
mod 'rsyslog',   :git => "#{base_url}/saz/puppet-rsyslog",  :tag => 'v3.5.1' #APPROVED
