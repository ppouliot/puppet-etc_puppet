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
  branch_name               = 'origin/havana'
  openstack_module_branch   = 'master'
  openstack_module_account  = 'stackforge'
  puppetlabs_module_account = 'puppetlabs'
  # manifests
  user_name = 'primeministerp'
  release = 'havana'
  manifest_branch = 'origin/master'
end

base_url     = "#{git_protocol}://github.com"
ssh_url      = "#{git_protocol}://github.com"
branch_name  = 'origin/havana'

###### Installer Manifests Example ##############
#mod 'manifests', :git => "#{base_url}/#{user_name}/#{release}-manifests", :ref => "#{manifest_branch}"

##### Puppet Labs modules #####

openstack_repo_prefix = "#{base_url}/#{openstack_module_account}/puppet"
mod 'r10k',                      :git => "#{base_url}/acidprime/r10k" #PRODUCTION #SUPPORTED
mod 'stdlib',          :git => "#{base_url}/puppetlabs/puppetlabs-stdlib",          :tag => '4.3.2' #SUPPORTED
mod 'vcsrepo',         :git => "#{base_url}/puppetlabs/puppetlabs-vcsrepo",         :tag => '1.1.0' #SUPPORTED
mod 'concat',          :git => "#{base_url}/puppetlabs/puppetlabs-concat",          :tag => '1.0.4' #SUPPORTED
mod 'apt',             :git => "#{base_url}/puppetlabs/puppetlabs-apt",             :tag => '1.6.0' #SUPPORTED
mod 'firewall',        :git => "#{base_url}/puppetlabs/puppetlabs-firewall",        :tag => '1.1.3' #SUPPORTED
mod 'ntp',             :git => "#{base_url}/puppetlabs/puppetlabs-ntp",             :tag => '3.1.2' #SUPPORTED
mod 'postgresql',      :git => "#{base_url}/puppetlabs/puppetlabs-postgresql",      :tag => '3.4.2' #SUPPORTED
mod 'apache',          :git => "#{base_url}/puppetlabs/puppetlabs-apache",          :tag => '1.1.1' #SUPPORTED
mod 'mysql',           :git => "#{base_url}/puppetlabs/puppetlabs-mysql",           :tag => '2.3.1' #SUPPORTED
mod 'inifile',         :git => "#{base_url}/puppetlabs/puppetlabs-inifile",         :tag => '1.1.3' #SUPPORTED
mod 'java',            :git => "#{base_url}/puppetlabs/puppetlabs-java",            :tag => '1.1.2' #SUPPORTED
mod 'java_ks',         :git => "#{base_url}/puppetlabs/puppetlabs-java_ks",         :tag => '1.2.5' #SUPPORTED
mod 'haproxy',         :git => "#{base_url}/puppetlabs/puppetlabs-haproxy",         :tag => '1.0.0' #SUPPORTED
mod 'registry',        :git => "#{base_url}/puppetlabs/puppetlabs-registry",        :tag => '1.0.3' #SUPPORTED #WINDOWS
mod 'reboot',          :git => "#{base_url}/puppetlabs/puppetlabs-reboot",          :tag => '0.1.8' #SUPPORTED #WINDOWS
mod 'powershell',      :git => "#{base_url}/puppetlabs/puppetlabs-powershell",      :tag => '1.0.3' #SUPPORTED #WINDOWS
mod 'tomcat',          :git => "#{base_url}/puppetlabs/puppetlabs-tomcat",          :tag => '1.2.0' #SUPPORTED
mod 'acl',             :git => "#{base_url}/puppetlabs/puppetlabs-acl",             :tag => '1.0.3' #SUPPORTED #WINDOWS
#mod 'sqlserver',       :git => "#{base_url}/puppetlabs/puppetlabs-sqlserver",       :tag => '1.0.0' #SUPPORTED #WINDOWS
mod 'sensu',         :git => "#{base_url}/sensu/sensu-puppet"            #APPROVED
mod 'epel',          :git => "#{base_url}/stahnma/puppet-module-epel"    #APPROVED
mod 'python',        :git => "#{base_url}/stankevich/puppet-python"      #APPROVED
mod 'jenkins',       :git => "#{base_url}/jenkinsci/puppet-jenkins"      #APPROVED
mod 'logrotate',     :git => "#{base_url}/rodjek/puppet-logrotate"       #APPROVED
mod 'elasticsearch',   :git => "#{base_url}/elasticsearch/puppet-elasticsearch" #APPROVED
mod 'erlang',        :git => "#{base_url}/garethr/garethr-erlang" #APPROVED
mod 'docker',        :git => "#{base_url}/garethr/garethr-docker" #APPROVED
mod 'augeasproviders',          :git => "#{base_url}/hercules-team/augeasproviders",          :tag => 'v2.0.0' #APPROVED
mod 'augeasproviders_shellvar',   :git => "#{base_url}/hercules-team/augeasproviders_shellvar",          :tag => '2.0.1' #APPROVED
mod 'augeasproviders_sysctl',     :git => "#{base_url}/hercules-team/augeasproviders_sysctl",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_ssh',        :git => "#{base_url}/hercules-team/augeasproviders_ssh",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_pam',        :git => "#{base_url}/hercules-team/augeasproviders_pam",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_mounttab',   :git => "#{base_url}/hercules-team/augeasproviders_mounttab",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_grub',       :git => "#{base_url}/hercules-team/augeasproviders_grub",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_base',       :git => "#{base_url}/hercules-team/augeasproviders_base",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_nagios',     :git => "#{base_url}/hercules-team/augeasproviders_nagios",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_apache',     :git => "#{base_url}/hercules-team/augeasproviders_apache",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_syslog',     :git => "#{base_url}/hercules-team/augeasproviders_syslog",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_postgresql', :git => "#{base_url}/hercules-team/augeasproviders_postgresql",          :tag => '2.0.0' #APPROVED
mod 'augeasproviders_puppet',     :git => "#{base_url}/hercules-team/augeasproviders_puppet",          :tag => '2.0.0' #APPROVED
mod 'wget',        :git => "#{base_url}/maestrodev/puppet-wget"       #APPROVED 
mod 'staging',          :git => "#{base_url}/nanliu/puppet-staging",          :tag => '1.0.0' #APPROVED
mod 'collectd', :git => "#{base_url}/pdxcat/puppet-module-collectd" #APPROVED
mod 'rsyslog',   :git => "#{base_url}/saz/puppet-rsyslog",  :tag => 'v3.4.0' #APPROVED
