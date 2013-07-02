exec { disable_selinux_sysconfig:
    command => '/bin/sed -i "s@^\(SELINUX=\).*@\1disabled@" /etc/selinux/config; echo 0 > /selinux/enforce',
    unless => '/bin/grep -q "SELINUX=disabled" /etc/selinux/config',
}

class { "emacs": }

class { "apache-server": }
->
exec { setup_vhosts:
  require => Package['httpd'],
  command => '/bin/sed -i "s@^#\(NameVirtualHost\.*\)@\1@" /etc/httpd/conf/httpd.conf; /etc/init.d/httpd reload',
  unless => '/bin/grep -q "^NameVirtualHost.*" /etc/httpd/conf/httpd.conf',
}

apache-vhost-git { "www.billy.org" :
   vhost_name      => "www.billy.org",
   git_source      => "git://github.com/embeepea/mysite.git",
}

# apache-vhost-git { "dashboard.nemac.org" :
#   vhost_name      => "dashboard.nemac.org",
#   git_source      => "https://github.com/embeepea/dashboard.nemac.org",
# }

## Here's an example of a way to import and use data variables (such as passwords)
## from an external file:
#
#import 'passwords'
#
#exec { password_demo:
#    command => "/bin/echo 'the password for the mysql user1 user is: $mysql_user1_password' > /tmp/password.log"
#}
