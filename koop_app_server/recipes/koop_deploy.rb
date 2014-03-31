#include_recipe 'deploy'
#node[:deploy].each do |application, deploy|

  directory node[:koop][:data_dir] do
    mode 0755
    action :create
  end

  template 'local.js' do
    cookbook 'koop_app_server'
    path "/srv/www/koop/current/config/local.js"
    source 'local.js.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

#end
