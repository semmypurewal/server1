exec { disable_selinux_sysconfig:
    command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config; echo 0 > /selinux/enforce',
    unless => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
}

class { "emacs": }

class { "apache-server": }
->
exec { setup_vhosts:
     command => '/bin/sed -i "s@^#\(NameVirtualHost\.*\)@\1@" /etc/httpd/conf/httpd.conf; /etc/init.d/httpd reload',
     unless => '/bin/grep -q "^NameVirtualHost.*" /etc/httpd/conf/httpd.conf',
}

apache-vhost-git { "www.billy.org" :
   vhost_name      => "www.billy.org",
   vhost_source    => "puppet:///files/www.billy.org.conf",
   git_source      => "git://github.com/embeepea/mysite.git",
   vhost_path      => "/var/www.billy.org/html"
}

apache-vhost-git { "www.semmy.org" :
   vhost_name      => "www.semmy.org",
   vhost_source    => "puppet:///files/www.semmy.org.conf",
   git_source      => "git://github.com/semmypurewal/homepage.git",
   vhost_path      => "/var/www.semmy.org/html"
}


## Here's an example of a way to import and use data variables (such as passwords)
## from an external file:
#
#import 'passwords'
#
#exec { password_demo:
#    command => "/bin/echo 'the password for the mysql user1 user is: $mysql_user1_password' > /tmp/password.log"
#}
