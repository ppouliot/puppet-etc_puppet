node 'maas0.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class{'maas':
# Uncomment to use the ubuntu:cloud-archive packages
#    cloud_archive_release => 'kilo',
  }

}
