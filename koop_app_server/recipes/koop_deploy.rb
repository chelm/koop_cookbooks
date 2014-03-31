include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  directory node[:koop][:data_dir] do
    mode 0755
    action :create
  end

  #template 'local.js' do
  #  cookbook 'koop_app_server'
  #  path "#{deploy[:deploy_to]}/config/local.js"
  #  source 'local.js.erb'
  #   owner deploy[:user]
  #   group deploy[:group]
  #  mode 0644
  #end

end
