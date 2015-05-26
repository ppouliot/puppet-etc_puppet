node 'review.openstack.tld' {
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")
  class{'staging':
    path  => '/opt/gerrit', 
    owner  => 'gerrit',
    group => 'gerrit',
  }
  staging::file{'gerrit-2.11.war':
    source => 'https://gerrit-releases.storage.googleapis.com/gerrit-2.11.war',
  }
  class{'gerrit':
    source => '/opt/gerrit/gerrit-2.11.war',
    target => '/opt/gerrit',
  }
}
