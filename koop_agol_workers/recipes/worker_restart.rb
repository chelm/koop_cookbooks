
execute 'pull koop-agol' do
  cwd "/koop-agol"
  command "git pull"
  ignore_failure false
end

execute 'npm install' do
  cwd "/koop-agol"
  command "npm install"
end

execute 'start workers' do
  cwd "/koop-agol/workers"
  command "pm2 restart request-worker"
end

