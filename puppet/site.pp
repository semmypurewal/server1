exec { disable_selinux_sysconfig:
    command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config',
    unless => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
}

class { "emacs": }

class { "apache-server": }

class { "apache-vhost-git" :
   vhost_name      => "www.billy.org",
   vhost_source    => "puppet:///files/www.billy.org.conf",
   git_source      => "git://github.com/embeepea/mysite.git"
}
