# == Class: manifests::site
#
# This implements Site wide defaults that 
# need to get run across every host regardless of platform
#
notice("Node ${fqdn} is puppet mananaged by the OpenStack Hyper-V CI team")

  case $kernel {
    'Linux':{
# Implement Site Wide Time Management
class {'profiles::time':
  ntpservers => 'pool.ntp.org',
  timezone   => 'UTC',
}
class{'profiles::mgmt_tools':}
  }
  default:{
    warning("we need to finish the windows time module so ${fqdn} can have it's time automatically set")
  }
}

# Remote Access 
#class{'profiles::remote_access':}
#  Management Tools
class{'profiles::mgmt_tools':}

# Monitoring Agent 
#class{'profiles::monitoring':
#}

case $environment {
  'production':{
    warning ("${fqdn} is in the production environment")
    validate_string($profiles::network_time_configured)
    validate_string($profiles::remote_access_enabled)
    validate_string($profiles::monitoring_enabled)
  }
  'staging':{
    warning ("${fqdn} is in the staging environment")
  }
  'testing':{
    warning ("${fqdn} is in the testing environment")
  }
  'development':{
    warning ("${fqdn} is in the development environment")
  }
}


case $osfamily {
  'Debian':{
    warning ("*** Debian OSFAMILY ***")
  }
  'RedHat':{
    warning ("*** RedHat OSFAMILY ***")
  }
  'Windows':{
    warning ("*** Windows OSFAMILY ***")
  }
  'FreeBSD':{
    warning ("***  FreeBSD OSFAMILY ***")
  }
  default:{
    warning ("!!! Unsupported OSFAMILY ${osfamily} !!!")
  }
}


case $operatingsystem {
  'debian':{
    warning ("*** Debian OS ***")
  }
  'ubuntu':{
    warning ("*** Ubuntu OS ***")
  }
  'redhat':{
    warning ("*** RedHat OS ***")
  }
  'windows':{
    warning ("*** Windows OS ***")
  }
  'freebsd':{
    warning ("***  FreeBSD OS ***")
  }
  default:{
    warning ("!!! Unsupported Operating System ${operatingsystem} !!!")
  }
}
if versioncmp($::puppetversion,'3.6.1') >= 0 {

  $allow_virtual_packages = hiera('allow_virtual_packages',false)

  Package {
    allow_virtual => $allow_virtual_packages,
  }
}
