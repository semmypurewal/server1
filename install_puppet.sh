rpm -q puppet > /dev/null
if [ $? -ne 0 ]; then
    rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm
    echo done
    yum -y install puppet
    puppet module install puppetlabs/vcsrepo
    echo done
fi



