node 'review.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class{'gerrit':
    mysql_password => 'gerrit'
  }
}
