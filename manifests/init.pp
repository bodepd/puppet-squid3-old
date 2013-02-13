#
# Performs basic configuration of squid
#
class squid3(
  $cache_mem                     = '256 MB',
  $maximum_object_size_in_memory = '512 KB',
  $maximum_object_size           = '4096 KB',
  $cache_dir                     = 'ufs /var/spool/squid3 100 16 256',
) {

  package { 'squid3':
    ensure => present,
  } ->
  File_line <||> ~>
  service { 'squid3':
    ensure => running,
    enable => true,
  }

  File_line {
    path => '/etc/squid3/squid.conf',
  }

  # various important lines!

  file_line { 'cache_mem':
    line  => "cache_mem ${cache_mem}",
    match => "^(#|)\s*cache_mem\s"
  }

  file_line { 'maximum_object_size_in_memory':
    line  => "maximum_object_size_in_memory ${maximum_object_size_in_memory}",
    match => "^(#|)\s*maximum_object_size_in_memory\s"
  }

  file_line { 'maximum_object_size':
    line  => "maximum_object_size ${maximum_object_size}",
    match => "^(#|)\s*maximum_object_size\s"
  }

  file_line { 'cache_dir':
    line  => "cache_dir ${cache_dir}",
    match => "^(#|)\s*cache_dir\s"
  }

}
