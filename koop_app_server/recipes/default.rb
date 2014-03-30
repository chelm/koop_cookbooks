include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  execute 'apt-get update' do
    command 'apt-get update'
    ignore_failure true
    only_if { apt_installed? }
    action :nothing
  end
  
  package 'libcairo2-dev' do
    action :install
  end
  
  package 'pkg-config' do
    action :install
  end
  
  package 'postgresql-9.3' do
    action :install
  end
  
  execute 'npm install -g grunt-cli forever' do
    command 'npm install -g grunt-cli forever'
    ignore_failure true
    only_if { apt_installed? }
    action :nothing
  end
  
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
