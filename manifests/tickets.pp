node 'tickets.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class{'osticket':}
}
