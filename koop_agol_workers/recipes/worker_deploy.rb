
execute 'rm koop-agol' do
  cwd "/"
  command "rm -rf koop-agol"
  ignore_failure true
end

execute 'install koop-agol' do
  cwd "/"
  command "git clone https://github.com/Esri/koop-agol.git"
  ignore_failure false
end

execute 'npm install' do
  cwd "/koop-agol"
  command "npm install"
  ignore_failure false
end

template 'default.json' do
  cookbook 'koop_agol_workers'
  path "/koop-agol/workers/config/default.json"
  source 'default.json.erb'
  owner 'root'
  group 'root'
  mode 0644
end

template 'pm2.json' do
  cookbook 'koop_agol_workers'
  path "/koop-agol/workers/pm2.json"
  source 'pm2.json.erb'
  owner 'root'
  group 'root'
  mode 0644
end

execute 'start workers' do
  cwd "/koop-agol/workers"
  command "pm2 start pm2.json"
  ignore_failure false
end

