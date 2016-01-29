node 'docker-sut.c2r1.openstack.tld' {
  notice("!!!!!!!!!!!!!!!!This node is for Docker-SUT testing!!!!!!!!!!!!!!!!!!!!!!")
}
node 'puppet-ipam.c2r1.openstack.tld' {
  notice("!!!!!!!!!!!!!!!!This node is for puppet-ipam module testing!!!!!!!!!!!!!!!!!!!!!!")
#  class{'ipam':}
}
node 'puppet-quartermaster.c2r1.openstack.tld' {
  notice("!!!!!!!!!!!!!!!!This node is for puppet-quartermaster module testing !!!!!!!!!!!!!!!!!!!!!")
#  class{'quartermaster':}
}
