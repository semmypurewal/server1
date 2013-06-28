require 'yaml'

aws_config = YAML.load_file('aws.yml')["aws"]

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  #  config.vm.box = "centos-6.4-base"

  #####################################################3
  config.vm.box = "base"
  config.vm.provider :aws do |aws, override|
    # perhaps eventually automate the config
    # aws_config['aws'].each_key do |k, v|
    #  puts k
    #  puts v
    # end
    # puts aws.inspect

    aws.instance_type     = aws_config["instance_type"]
    aws.access_key_id     = aws_config["access_key_id"]
    aws.secret_access_key = aws_config["secret_access_key"]
    aws.keypair_name      = aws_config["keypair_name"]
    aws.security_groups   = aws_config["security_groups"]
    aws.ami = aws_config["ami"]

    override.ssh.username         = "root"
    override.ssh.private_key_path = "nemactestkey.pem"
  end
  #####################################################3

  config.vm.synced_folder "./puppet", "/etc/puppet/files"

  config.vm.provision :shell,
   :inline => 'rpm -Uvh http://yum.puppetlabs.com/el/6/products/i386/puppetlabs-release-6-7.noarch.rpm ; echo done'

  config.vm.provision :shell,
   :inline => 'yum -y install puppet'

  config.vm.provision :shell,
     :inline => 'puppet module install puppetlabs/vcsrepo ; echo done'

  config.vm.provision :puppet,
    :options => ["--fileserverconfig=/vagrant/puppet/fileserver.conf"] do
      |puppet|
    puppet.module_path    = "puppet/modules"
    puppet.manifests_path = "puppet"
    puppet.manifest_file  = "site.pp"
  end
end
