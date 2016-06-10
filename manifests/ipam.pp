# Node Definition for DNS/DHCP infra

node /^(norman|mother|ns[0-9\.]+)/ {
# Legacy stuff commented out, rest handled by site.pp and hiera.
#  include basenode::params
#  package {$nfs_packages:
#    ensure => latest,
#  }
#  create_resources(basenode::nfs_mounts,$nfs_mounts)
# Sensu is currently disabled
#  class {'sensu':}
#  class {'sensu_client_plugins': require => Class['sensu'],}
  class { 'ipam': }
}

