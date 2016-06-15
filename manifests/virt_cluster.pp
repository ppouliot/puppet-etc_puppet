node 'eth0-c2-r13-u07','eth0-c2-r13-u11' {
  class{'profiles::kvm_host':}
  class{'corosync':
    enable_secauth           => true,
    authkey                  => '/var/lib/puppet/ssl/certs/ca.pem',
    bind_address             => $ipaddress_eth1,
    multicast_address        => '239.1.1.2',
    set_votequorum           => true,
    quorum_members           => ['10.13.2.7','10.13.2.11'],
    manage_pacemaker_service => true,
    force_online             => true,
    package_pcs              => true,
  }
  cs_primitive { 'dlm':
    primitive_class => 'ocf',
    primitive_type  => 'controld',
    provided_by     => 'pacemaker',
    parameters      => [
      {'daemon' => 'dlm_controld', }
    ],
    operations      => [
      { 'start'     => { 'interval' => '0', 'timeout' => '90s', 'on-fail' => 'restart' } },
      { 'stop'      => { 'interval' => '0', 'timeout' => '90s', 'on-fail' => 'restart' } },
      { 'monitor'   => { 'interval' => '10s',} }
    ],
  }
  cs_primitive { 'drbd0':
    primitive_class => 'ocf',
    primitive_type  => 'drbd',
    provided_by     => 'linbit',
    parameters      => [
      {'drbd_resource'  => 'r0', }
    ],
    operations      => [
      { 'monitor'   => { 'interval' => '20s', 'timeout' => '20s', 'role' => 'Master' } },
      { 'monitor'   => { 'interval' => '30s', 'timeout' => '20s', 'role' => 'Slave' } },
      { 'start'     => { 'interval' => '0', 'timeout' => '240s' } },
      { 'stop'      => { 'interval' => '0', 'timeout' => '120s' } }
    ],
  }
  cs_primitive { 'drbd1':
    primitive_class => 'ocf',
    primitive_type  => 'drbd',
    provided_by     => 'linbit',
    parameters      => [
      {'drbd_resource'  => 'r1', }
    ],
    operations      => [
      { 'monitor'   => { 'interval' => '20s', 'timeout' => '20s', 'role' => 'Master' } },
      { 'monitor'   => { 'interval' => '30s', 'timeout' => '20s', 'role' => 'Slave' } },
      { 'start'     => { 'interval' => '0', 'timeout' => '240s' } },
      { 'stop'      => { 'interval' => '0', 'timeout' => '120s' } }
    ],
  }
  cs_primitive { 'o2cb':
    primitive_class => 'ocf',
    primitive_type  => 'o2cb',
    provided_by     => 'pacemaker',
    parameters      => [
      {'stack'  => 'cman', }
    ],
    operations      => [
      { 'monitor'   => { 'interval' => '10s' } },
      { 'start'     => { 'interval' => '0', 'timeout' => '90s' } },
      { 'stop'      => { 'interval' => '0', 'timeout' => '100s' } }
    ],
  }
  cs_primitive {'ocfs2-0':
    primitive_class => 'ocf',
    primitive_type  => 'Filesystem',
    provided_by     => 'heartbeat',
    parameters      => {
      'device'     => '/dev/drdbd0',
      'directory'  => '/etc/libvirt/qemu',
      'fstype'     => 'ocfs2', 
      'options'    => 'acl', 
    },
    operations      => [
      { 'monitor'   => { 'interval' => '120s','timeout' => '40' } },
    ],
  }
  cs_primitive {'ocfs2-1':
    primitive_class => 'ocf',
    primitive_type  => 'Filesystem',
    provided_by     => 'heartbeat',
    parameters      => {
      'device'    => '/dev/drdbd1',
      'directory' => '/var/lib/qemu/images',
      'fstype'    => 'ocfs2',
      'options'    => 'acl',
    },
    operations      => [
      { 'monitor'   => { 'interval' => '120s','timeout' => '40' } },
    ],
  }
  cs_clone{'dlm-clone':
    ensure         => present,
    primitive       => 'dlm',
    globally_unique => false,
    interleave      => true,
  }
  cs_clone{'o2cb-clone':
    ensure         => present,
    primitive       => 'dlm',
    globally_unique => false,
    interleave      => true,
  }
#  cs_colocation{'colo-dlm-drbd0':
#    primitives => [
#      ['dlm-clone','ms-drbd0:Master'],
#    ],
#  }
#  cs_colocation{'colo-o2cb-dlm':
#    primitives => [
#      ['o2cb-clone','dlm-clone'],
#    ],
#  }

  package{'ocfs2-tools':
    ensure => latest,
  }
  package{[
    'lvm2',
    'clvm']:
    ensure => latest,
  } ->
  physical_volume { "/dev/sdb1":
    ensure => present,
    unless_vg => "vg_drbd_ocfs2"
  }
  volume_group { 'vg_drbd_ocfs2':
    ensure           => present,
    physical_volumes => '/dev/sdb1',
  }

  logical_volume{'lv_drbd_etc_libvirt_qemu':
    ensure       => present,
    volume_group => 'vg_drbd_ocfs2',
    size         => '10G',
  } 
  logical_volume{'lv_drbd_var_libvirt_images':
    ensure       => present,
    volume_group => 'vg_drbd_ocfs2',
    size         => '850G',
  }
#  class{'drbd':
#  } ->
  include ::drbd
  drbd::resource{'r0':
 #   device        => '/dev/drbd0',
    disk          => '/dev/mapper/vg_drbd_ocfs2-lv_drbd_etc_libvirt_qemu',
    secret        => 'secret',
    #host1         => 'eth0-c2-r13-u07',
    #host2         => 'eth0-c2-r13-u11',
    #ip1           => '10.13.2.7',
    #ip2           => '10.13.2.11',
    cluster       => [ 'eth0-c2-r13-u07','eth0-c2-r13-u11'],
    port          => 7788,
    ha_primary    => true,
    allow_two_primaries => true,
    net_parameters => {
      'after-sb-0pri'       => 'discard-zero-changes',
      'after-sb-1pri'       => 'discard-secondary',
      'after-sb-2pri'       => 'disconnect',
    },
    initial_setup => true,
    require       => Logical_volume['lv_drbd_etc_libvirt_qemu']
  }
  drbd::resource{'r1':
    host1         => 'eth0-c2-r13-u07',
    host2         => 'eth0-c2-r13-u11',
    ip1           => '10.13.2.7',
    ip2           => '10.13.2.11',
    device        => '/dev/drbd1',
    disk          => '/dev/mapper/vg_drbd_ocfs2-lv_drbd_var_libvirt_images',
    secret        => 'secret',
    cluster       => [ 'eth0-c2-r13-u07','eth0-c2-r13-u11'],
    port          => 7789,
    allow_two_primaries => true,
    ha_primary    => true,
    net_parameters => {
      'after-sb-0pri' => 'discard-zero-changes',
      'after-sb-1pri' => 'discard-secondary',
      'after-sb-2pri' => 'disconnect'
    },   
    initial_setup => true,
    require       => Logical_volume['lv_drbd_etc_libvirt_qemu']
  }
}
