node 'review.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class{'profiles::gerrit_gate':}
}
