
execute 'install koop-agol' do
  cwd "/"
  command "git clone https://github.com/Esri/koop-agol.git"
  ignore_failure false
end

execute 'npm install' do
  cwd "/koop-agol"
  command "npm install"
end

template 'default.json' do
  cookbook 'koop_agol_workers'
  path "/workers/config/default.json"
  source 'default.json.erb'
  owner 'root'
  group 'root'
  mode 0644
end

execute 'start workers' do
  cwd "/koop-agol/workers"
  command "pm2 start request_worker.js"
end

