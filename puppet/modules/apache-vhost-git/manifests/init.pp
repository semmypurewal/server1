define apache-vhost-git($vhost_name, $git_source) {
  include git                          

  vcsrepo { $vhost_name:
    require => Package['git'],
    path => "/var/${vhost_name}",
    ensure   => present,
    provider => git,
    source   => $git_source
  }
  ->
  apache-vhost { $vhost_name :
    require => Vcsrepo[$vhost_name],
    vhost_name   => $vhost_name,
  }
}


