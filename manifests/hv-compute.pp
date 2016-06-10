#
node /^hv-compute[0-9]+\.openstack\.tld$/{
  case $kernel {
    'Windows':{
      File {
        source_permissions => ignore,
      }

      class {'windows_common':}
      class {'windows_common::configuration::disable_firewalls':}
      class {'windows_common::configuration::disable_auto_update':}
      class {'windows_common::configuration::enable_iscsi_initiator':}
#      class {'windows_common::configuration::ntp':
 #       before => Class['windows_openssl'],
 #     }
#      class {'windows_common::configuration::rdp':}
      class {'windows_openssl': }
      class {'java': distribution => 'jre' }

      virtual_switch { 'br100':
        notes             => 'Switch bound to main address fact',
        type              => 'External',
        os_managed        => true,
        interface_address => '10.0.*',
      }

      #class {'windows_freerdp': }

      class {'windows_git': before => Class['cloudbase_prep'],}
      class {'cloudbase_prep': }
      class {'jenkins::slave':
        install_java      => false,
        require           => [Class['java'],Class['cloudbase_prep']],
        manage_slave_user => false,
        executors         => 1,
        labels            => 'hv-staging',
        masterurl         => 'http://jenkins.openstack.tld:8080',
      }
      #if !defined (Windows_python::Dependency['PyYAML']){
      #  windows_python::dependency{ 'PyYAML':
      #    type    => pip,
      #    require => Class['cloudbase_prep'],
      #  }
      #}

#      $q_ip = '10.21.7.22'
#      $nfs_location = "\\\\${q_ip}\\nfs"
#      file { "${nfs_location}":
#        ensure => directory,
#      }
#      file { "${nfs_location}\\facter":
#        ensure => directory,
#        require => File["$nfs_location"],
#      }
#      exec {"${hostname}-facter":
#        command => "\"C:\\Program Files (x86)\\Puppet Labs\\Puppet\\bin\\facter.bat\" -py > C:\\ProgramData\\facter.yaml",
#      }
#      file { "${nfs_location}\\facter\\${hostname}.yaml":
#        ensure  => file,
#        source  => 'C:\ProgramData\facter.yaml',
#        require => File["${nfs_location}\\facter"],
#        subscribe => Exec["${hostname}-facter"],
#      }

    }
    default:{
      notify{"${kernel} on ${fqdn} doesn't belong here":}
    }
  }

}

# Limit production nodes to explicitly defined machines.
node 

     
     'c2-r1-u01.openstack.tld',
     'c2-r1-u01.ad.openstack.tld',
     'c2-r1-u02.openstack.tld',
     'c2-r1-u02.ad.openstack.tld',
     'c2-r1-u03.openstack.tld',
     'c2-r1-u04.openstack.tld',
     'c2-r1-u05.openstack.tld',
     'c2-r1-u06.openstack.tld',
     'c2-r1-u07.openstack.tld', ## Fails to respond to WSMan -- Timeout
     'c2-r1-u08.openstack.tld', ## Fails to respond to WSMan -- Timeout
     'c2-r1-u09.openstack.tld', ## Fails to respond to WSMan -- Timeout
     'c2-r1-u10.openstack.tld', ## Fails to respond to WSMan -- Timeout
     'c2-r1-u11.openstack.tld', ## errors on node, requires review/reconfig > "In review, 2015-03-17"-Tim
     'c2-r1-u12.openstack.tld',
     'c2-r1-u13.openstack.tld',
     'c2-r1-u14.openstack.tld',
     'c2-r1-u15.openstack.tld',
     'c2-r1-u16.openstack.tld',
     'c2-r1-u17.openstack.tld',
     'c2-r1-u18.openstack.tld',
     'c2-r1-u18.ad.openstack.tld',
     'c2-r1-u19.openstack.tld',
     'c2-r1-u20.openstack.tld',
     'c2-r1-u21.openstack.tld',
     'c2-r1-u22.openstack.tld',
     'c2-r1-u23.openstack.tld',
     'c2-r1-u24.openstack.tld',
     'c2-r1-u25.openstack.tld',
     'c2-r1-u26.openstack.tld',
     'c2-r1-u30.openstack.tld',
     'c2-r1-u30.ad.openstack.tld',
#     'c2-r1-u31.openstack.tld',  ## assigned as Docker
     'c2-r1-u32.openstack.tld',
#     'c2-r1-u33.openstack.tld',  ## defined elsewhere
#     'c2-r1-u34.openstack.tld',
     'c2-r1-u36.openstack.tld',
     'c2-r1-u40.openstack.tld',
     'c2-r2-u02.openstack.tld',
     'c2-r2-u03.openstack.tld',
     'c2-r2-u04.openstack.tld',
     'c2-r2-u05.openstack.tld',
     'c2-r2-u06.openstack.tld',
     'c2-r2-u06.ad.openstack.tld',
     'c2-r2-u07.openstack.tld',
     'c2-r2-u08.openstack.tld',
     'c2-r2-u09.openstack.tld',
     'c2-r2-u10.openstack.tld',
     'c2-r2-u11.openstack.tld',
     'c2-r2-u12.openstack.tld',
     'c2-r2-u14.openstack.tld',
     'c2-r2-u15.openstack.tld',
     'c2-r2-u15.ad.openstack.tld',
     'c2-r2-u16.openstack.tld',
     'c2-r2-u17.openstack.tld',
     'c2-r2-u19.openstack.tld',
#     'c2-r2-u20.openstack.tld', ## colo neuton-controller
     'c2-r2-u21.openstack.tld',
     'c2-r2-u22.openstack.tld',
     'c2-r2-u23.openstack.tld',
     'c2-r2-u24.openstack.tld', 
     'c2-r2-u25.openstack.tld',
     'c2-r2-u26.openstack.tld',
     'c2-r2-u27.ad.openstack.tld',
     'c2-r2-u27.openstack.tld',
     'c2-r2-u28.ad.openstack.tld',
     'c2-r2-u30.ad.openstack.tld',
     'c2-r2-u31.ad.openstack.tld',
     'c2-r2-u33.ad.openstack.tld',
     'c2-r2-u35.ad.openstack.tld',
     'c2-r2-u36.ad.openstack.tld',
     'c2-r2-u37.ad.openstack.tld',
     'c2-r2-u38.openstack.tld', ## errors on node, requires review/reconfig
     'c2-r2-u39.ad.openstack.tld',
     'c2-r2-u40.openstack.tld',
#     'hv-compute100.openstack.tld', ## assigned as Hopper (ticket system)
     'hv-compute101.openstack.tld', ## Fails to respond to WSMan -- DNS
#     'hv-compute103.openstack.tld', ## assigned as build automation node
     'hv-compute104.openstack.tld', ## Fails to respond to WSMan -- DNS
#     'hv-compute105.openstack.tld', ## reassigned to KVM -> kvm-compute105
     'hv-compute106.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute107.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute108.openstack.tld', ## Fails to respond to WSMan -- DNS
#     'hv-compute114.openstack.tld',
     'hv-compute115.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute116.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute117.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute118.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute119.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute120.openstack.tld', ## Fails to respond to WSMan -- DNS
#     'hv-compute121.openstack.tld',
     'hv-compute122.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute123.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute124.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute125.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute126.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute127.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute128.openstack.tld', ## Fails to respond to WSMan -- DNS
#     'hv-compute132.openstack.tld',
     'hv-compute137.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute139.openstack.tld', ## Fails to respond to WSMan -- DNS
     'hv-compute140.openstack.tld',
#     'hv-compute143.openstack.tld',
     'hv-compute147.openstack.tld', ## Fails to respond to WSMan -- Host unreachable
     'hv-compute149.openstack.tld',
     'hv-compute159.openstack.tld',
     'hv-compute162.openstack.tld', ## Fails to respond to WSMan -- Actively refused
     'hv-compute167.openstack.tld', ## Fails to respond to WSMan -- Actively refused
     'hv-compute170.openstack.tld', ## Fails to respond to WSMan -- Timeout

# rack 16
     'c2-r16-u01.openstack.tld',
     'c2-r16-u01.ad.openstack.tld',
     'c2-r16-u03.openstack.tld',
     'c2-r16-u03.ad.openstack.tld',
     'c2-r16-u05.openstack.tld',
     'c2-r16-u05.ad.openstack.tld',
     'c2-r16-u07.openstack.tld',
     'c2-r16-u07.ad.openstack.tld',
     'c2-r16-u09.openstack.tld',
     'c2-r16-u09.ad.openstack.tld',
     'c2-r16-u11.openstack.tld',
     'c2-r16-u11.ad.openstack.tld',
     'c2-r16-u13.openstack.tld',
     'c2-r16-u13.ad.openstack.tld',
     'c2-r16-u15.openstack.tld',
     'c2-r16-u15.ad.openstack.tld',
     'c2-r16-u17.openstack.tld',
     'c2-r16-u17.ad.openstack.tld',
     'c2-r16-u19.openstack.tld',
     'c2-r16-u19.ad.openstack.tld',
     'c2-r16-u21.openstack.tld',
     'c2-r16-u21.ad.openstack.tld',
     'c2-r16-u23.openstack.tld',
     'c2-r16-u23.ad.openstack.tld',
     'c2-r16-u25.openstack.tld',
     'c2-r16-u25.ad.openstack.tld',
#     'c2-r16-u27.openstack.tld',
#     'c2-r16-u27.ad.openstack.tld',
     'c2-r16-u29.openstack.tld',
     'c2-r16-u29.ad.openstack.tld',
     'c2-r16-u31.openstack.tld',
     'c2-r16-u31.ad.openstack.tld',
     'c2-r16-u33.openstack.tld',
     'c2-r16-u33.ad.openstack.tld',
     'c2-r16-u34.openstack.tld',
     'c2-r16-u34.ad.openstack.tld',
     'c2-r16-u35.openstack.tld',
     'c2-r16-u35.ad.openstack.tld',
     'c2-r16-u36.openstack.tld',
     'c2-r16-u36.ad.openstack.tld',

# rack 15
     'c2-r15-u01.openstack.tld',
     'c2-r15-u01.ad.openstack.tld',
     'c2-r15-u03.openstack.tld',
     'c2-r15-u03.ad.openstack.tld',
     'c2-r15-u05.openstack.tld',
     'c2-r15-u05.ad.openstack.tld',
     'c2-r15-u07.openstack.tld',
     'c2-r15-u07.ad.openstack.tld',
     'c2-r15-u09.openstack.tld',
     'c2-r15-u09.ad.openstack.tld',
     'c2-r15-u11.openstack.tld',
     'c2-r15-u11.ad.openstack.tld',
     'c2-r15-u13.openstack.tld',
     'c2-r15-u13.ad.openstack.tld',
     'c2-r15-u15.openstack.tld',
     'c2-r15-u15.ad.openstack.tld',
     'c2-r15-u17.openstack.tld',
     'c2-r15-u17.ad.openstack.tld',
     'c2-r15-u19.openstack.tld',
     'c2-r15-u19.ad.openstack.tld',
     'c2-r15-u21.openstack.tld',
     'c2-r15-u21.ad.openstack.tld',
     'c2-r15-u23.openstack.tld',
     'c2-r15-u23.ad.openstack.tld',
     'c2-r15-u25.openstack.tld',
     'c2-r15-u25.ad.openstack.tld',
     'c2-r15-u27.openstack.tld',
     'c2-r15-u27.ad.openstack.tld',
     'c2-r15-u29.openstack.tld',
     'c2-r15-u29.ad.openstack.tld',
     'c2-r15-u31.openstack.tld',
     'c2-r15-u31.ad.openstack.tld',
     'c2-r15-u33.openstack.tld',
     'c2-r15-u33.ad.openstack.tld',
     'c2-r15-u35.openstack.tld',
     'c2-r15-u35.ad.openstack.tld',
     'c2-r15-u36.openstack.tld',
     'c2-r15-u36.ad.openstack.tld',
    
# rack 17
     'c2-r17-u01.openstack.tld',
     'c2-r17-u01.ad.openstack.tld',
     'c2-r17-u02.openstack.tld',
     'c2-r17-u02.ad.openstack.tld',
     'c2-r17-u03.openstack.tld',
     'c2-r17-u03.ad.openstack.tld',
     'c2-r17-u04.openstack.tld',
     'c2-r17-u04.ad.openstack.tld',
     'c2-r17-u05.openstack.tld',
     'c2-r17-u05.ad.openstack.tld',
     'c2-r17-u06.openstack.tld',
     'c2-r17-u06.ad.openstack.tld',
     'c2-r17-u07.openstack.tld',
     'c2-r17-u07.ad.openstack.tld',
     'c2-r17-u08.openstack.tld',
     'c2-r17-u08.c2r17.openstack.tld',
     'c2-r17-u08.ad.openstack.tld',
     'c2-r17-u09.openstack.tld',
     'c2-r17-u09.ad.openstack.tld',
     'c2-r17-u10.openstack.tld',
     'c2-r17-u10.ad.openstack.tld',
     'c2-r17-u11.openstack.tld',
     'c2-r17-u11.ad.openstack.tld',
     'c2-r17-u12.openstack.tld',
     'c2-r17-u12.ad.openstack.tld',
     'c2-r17-u13.openstack.tld',
     'c2-r17-u13.ad.openstack.tld',
     'c2-r17-u14.openstack.tld',
     'c2-r17-u14.ad.openstack.tld',
     'c2-r17-u15.openstack.tld',
     'c2-r17-u15.ad.openstack.tld',
     'c2-r17-u16.openstack.tld',
     'c2-r17-u16.ad.openstack.tld',
     'c2-r17-u17.openstack.tld',
     'c2-r17-u17.ad.openstack.tld',
     'c2-r17-u18.openstack.tld',
     'c2-r17-u18.ad.openstack.tld',
     'c2-r17-u19.openstack.tld',
     'c2-r17-u19.ad.openstack.tld',
     'c2-r17-u20.openstack.tld',
     'c2-r17-u20.ad.openstack.tld',
     'c2-r17-u21.openstack.tld',
     'c2-r17-u21.ad.openstack.tld',
     'c2-r17-u22.openstack.tld',
     'c2-r17-u22.ad.openstack.tld',
     'c2-r17-u23.openstack.tld',
     'c2-r17-u23.ad.openstack.tld',
     'c2-r17-u24.openstack.tld',
     'c2-r17-u24.ad.openstack.tld',
     'c2-r17-u25.openstack.tld',
     'c2-r17-u25.ad.openstack.tld',
     'c2-r17-u26.openstack.tld',
     'c2-r17-u26.ad.openstack.tld',
     'c2-r17-u27.openstack.tld',
     'c2-r17-u27.ad.openstack.tld',
     'c2-r17-u28.openstack.tld',
     'c2-r17-u28.ad.openstack.tld',
     'c2-r17-u29.openstack.tld',
     'c2-r17-u29.ad.openstack.tld',
     'c2-r17-u30.openstack.tld',
     'c2-r17-u30.ad.openstack.tld',
     'c2-r17-u31.openstack.tld',
     'c2-r17-u31.ad.openstack.tld',
     'c2-r17-u32.openstack.tld',
     'c2-r17-u32.ad.openstack.tld'

{
  case $kernel {
    'Windows':{
      File {
        source_permissions => ignore,
      }

      class {'windows_common':}
      class {'windows_common::configuration::disable_firewalls':}
      class {'windows_common::configuration::disable_auto_update':}
      class {'windows_common::configuration::enable_iscsi_initiator':}
#      class {'windows_common::configuration::ntp':
 #       before => Class['windows_openssl'],
 #     }
    #  class {'windows_common::configuration::rdp':}
      class {'windows_openssl': }
      class {'java': distribution => 'jre' }

      virtual_switch { 'br100':
        notes             => 'Switch bound to main address fact',
        type              => 'External',
        os_managed        => true,
        interface_address => '10.0.*',
      }

      class {'windows_git': before => Class['cloudbase_prep'],}
      
      class {'cloudbase_prep': }
      class {'windows_freerdp': }

#      $python_logging_file = 'c:/Python27/Lib/logging/__init__.py'
#      if (!defined(File[$python_logging_file])) {
#        file {$python_logging_file:
#          ensure  => present,
#          require => Class['cloudbase_prep'],
#        }
#      }
#
#      exec {'fix_python_logging_threading':
#        provider => powershell,
#        command  => "
#          \$newcontent = ((([IO.File]::ReadAllText('${python_logging_file}')) -creplace '(except ImportError:[\\n\\s]+thread = None)([\\n\\s]+?)(\\r\\n)(?:from eventlet import patcher[\\n\\s]+thread = patcher.original(''thread'')[\\n\\s]+threading = patcher.original(''threading'')[\\n\\s]+)?__author__','\$1\$2\$3from eventlet import patcher\$3thread = patcher.original(''thread'')\$3threading = patcher.original(''threading'')\$2\$3__author__') -creplace 'test-Tim','')
#          [IO.File]::WriteAllText('${python_logging_file}',\$newcontent)
#        ",
#        require => File[$python_logging_file],
#      }
      
      class {'jenkins::slave': 
        install_java      => false,
        require           => [Class['java'],Class['cloudbase_prep']],
        manage_slave_user => false,
        executors         => 1,
#        labels            => $jenkins_label,
#        masterurl         => 'http://jenkins.openstack.tld:8080',
        labels            => $jenkins_label,
        masterurl         => $jenkins_host,
      }

#      $q_ip = '10.21.7.22'
#      $nfs_location = "\\\\${q_ip}\\nfs"
#      file { "${nfs_location}":
#        ensure => directory,
#      }
#      file { "${nfs_location}\\facter":
#        ensure => directory,
#        require => File["$nfs_location"],
#      }
#      exec {"${hostname}-facter":
#        command => "\"C:\\Program Files (x86)\\Puppet Labs\\Puppet\\bin\\facter.bat\" -py > C:\\ProgramData\\facter.yaml",
#      }
#      file { "${nfs_location}\\facter\\${hostname}.yaml":
#        ensure  => file,
#        source  => 'C:\ProgramData\facter.yaml',
#        require => File["${nfs_location}\\facter"],
#        subscribe => Exec["${hostname}-facter"],
#      }

    }
    'Linux':{
       notify{"${kernel} on ${fqdn} is running Linux":}
      class{'dell_openmanage':}
      class{'dell_openmanage::firmware::update':}
    }
    default:{
      notify{"${kernel} on ${fqdn} doesn't belong here":}
    }
  }
}
