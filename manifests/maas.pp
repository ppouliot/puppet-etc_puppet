node 'maas0.openstack.tld' {
  warning("** WARNING *** ${fqdn} is puppet Mananaged by the puppetmaster -> %% moneypenny.openstack.tld %%")
  class{'maas':
# Uncomment to use the ubuntu:cloud-archive packages
#    cloud_archive_release => 'kilo',
  }

}
