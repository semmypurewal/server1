class apache-server {

  package { 'httpd':
    ensure => 'present'
  }

  service { 'httpd':
    require => Package['httpd'],
    ensure => running
  }

}
