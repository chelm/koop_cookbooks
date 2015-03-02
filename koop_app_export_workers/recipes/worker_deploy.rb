
directory node[:koop][:data_dir] do
  mode 0755
  action :create
end

execute 'rm koop' do
  cwd "/"
  command "rm -rf koop"
  ignore_failure true
end

execute 'install koop' do
  cwd "/"
  command "git clone https://github.com/Esri/koop.git"
  ignore_failure false
end

execute 'npm install' do
  cwd "/koop"
  command "npm install"
  ignore_failure false
end

execute 'npm install pg-cache' do
  cwd "/koop"
  command "npm install koop-pgcache"
  ignore_failure false
end

directory 'koop/config' do
  mode 0755
  action :create
end

template 'default.json' do
  cookbook 'koop_app_export_workers'
  path "/koop/config/default.json"
  source 'default.json.erb'
  owner 'root'
  group 'root'
  mode 0644
end

template 'pm2.json' do
  cookbook 'koop_app_export_workers'
  path "/koop/lib/pm2.json"
  source 'pm2.json.erb'
  owner 'root'
  group 'root'
  mode 0644
end

execute 'stop export workers' do
  cwd "/koop"
  command "pm2 stop all"
  ignore_failure true
end

execute 'start export workers' do
  cwd "/koop"
  command "pm2 start lib/pm2.json"
  ignore_failure false
end

