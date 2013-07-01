define apache-vhost-git($vhost_name, $vhost_source, $git_source, $vhost_path) {
  include git                          

  apache-vhost { $vhost_name :
    vhost_name   => $vhost_name,
    vhost_source => $vhost_source
  }

  vcsrepo { $vhost_name:
    require => Package['git'],
    path => $vhost_path,
    ensure   => present,
    provider => git,
    source   => $git_source
  }
}


