execute 'npm install -g grunt-cli forever' do
  command 'sudo npm install -g grunt-cli forever'
  ignore_failure false
end

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

execute 'compile assets' do
  cwd "/srv/www/koop/current"
  command 'sudo grunt compileAssets'
  ignore_failure false
end

