
execute 'rm koop-server' do
  cwd "/"
  command "rm -rf koop-server"
  ignore_failure true
end

execute 'install koop-agol' do
  cwd "/"
  command "git clone https://github.com/Esri/koop-server.git"
  ignore_failure false
end

execute 'npm install' do
  cwd "/koop-server"
  command "npm install"
  ignore_failure false
end

template 'default.json' do
  cookbook 'koop_app_export_workers'
  path "/koop-server/config/default.json"
  source 'default.json.erb'
  owner 'root'
  group 'root'
  mode 0644
end

execute 'start export workers' do
  cwd "/koop-server"
  command "pm2 start lib/ExportWorker.js"
  ignore_failure false
end
