include_recipe 'apt'
include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  apt_repository 'apt.postgresql.org' do
    components ['main']
    distribution "#{node['lsb']['codename']}-pgdg"
    key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
    notifies :run, 'execute[apt-get update]', :immediately
    uri 'http://apt.postgresql.org/pub/repos/apt'
  end
  
  package 'pkg-config'
  package 'libcairo2-dev'
  package "pgdg-keyring"
  package 'libgdal-dev'
  package 'libpq-dev'
  package 'postgresql-9.3'
  package 'postgresql-client-9.3'
  package 'postgresql-server-dev-all'
  
  directory node[:koop][:data_dir] do
    mode 0755
    action :create
  end

  template 'local.js' do
    path "#{deploy[:deploy_to]}/local.js"
    source 'local.js.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

end

#
#  execute 'apt-get update' do
#    command 'apt-get update'
#    ignore_failure true
#    only_if { apt_installed? }
#    action :nothing
#  end
#  
#  package 'libcairo2-dev' do
#    action :install
#  end
#  
#  package 'pkg-config' do
#    action :install
#  end
#  
#  package 'postgresql-9.3' do
#    action :install
#  end
#  
#  execute 'npm install -g grunt-cli forever' do
#    command 'npm install -g grunt-cli forever'
#    ignore_failure true
#    only_if { apt_installed? }
#    action :nothing
#  end
#  
  
#  template 'local.js' do
#    path "#{deploy[:deploy_to]}/local.js"
#    source 'local.js.erb'
#    owner 'root'
#    group 'root'
#    mode 0644
#  end

#end
