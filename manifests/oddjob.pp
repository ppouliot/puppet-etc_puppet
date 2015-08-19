node /^(oddjob[0-1]).openstack.tld/{
  warning("${fqdn} is puppet mananaged by moneypenny.openstack.tld")

  # Begin -> Celso's code goes between these marks

  case $kernel {
    'Linux':{
      $some_path = '/opt'
    }
    'windows':{
      $some_path = 'C:/'
    }
    default:{
      warning ("!!! Unsupported OSFAMILY ${osfamily} !!!")
    }
  }
  
  file{"${some_path}/script1.bat":
    source => "puppet:///extra_files/script.bat",
    owner  => 'root',
    group  => 'wheel',
    mode   => '0777',
  }
  file{"${some_path}/script2.bat":
    source => "puppet:///extra_files/script.bat",
    owner  => 'root',
    group  => 'wheel',
    mode   => '0777',
  }
  file{"${some_path}/script3.bat":
    source => "puppet:///extra_files/script.bat",
    owner  => 'root',
    group  => 'wheel',
    mode   => '0777',
  }
  # End
  # End
  # End
}
