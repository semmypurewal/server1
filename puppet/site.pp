
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


## Here's an example of a way to import and use data variables (such as passwords)
## from an external file:
#
#import 'passwords'
#
#exec { password_demo:
#    command => "/bin/echo 'the password for the mysql user1 user is: $mysql_user1_password' > /tmp/password.log"
#}
