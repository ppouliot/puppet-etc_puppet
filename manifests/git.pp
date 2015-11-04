node 'git.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class {'apt':} ->
  class { 'gitlab':
    external_url => 'http://git.openstack.tld',
  }
}
