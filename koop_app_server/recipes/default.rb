include_recipe 'deploy'
include_recipe 'nginx'

chef_gem 'chef-rewind'
require 'chef/rewind'

node[:deploy].each do |application, deploy|
  unicorn_template = "#{node[:nginx][:dir]}/sites-available/#{application}"

  rewind :template => unicorn_template do
    cookbook_name 'arcgis_open_data_app_server'
    group 'root'
    mode 0644
    notifies :reload, 'service[nginx]', :delayed
    owner 'root'
    source 'nginx.conf.erb'
    variables :application => application
  end
end
