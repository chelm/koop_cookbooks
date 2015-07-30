include_recipe 'deploy'

directory node[:koop][:data_dir] do
  mode 0755
  action :create
end

node[:deploy].each do |application, deploy|
  template 'default.json' do
    cookbook 'koop_app_server'
    path "#{deploy[:current_path]}/config/default.json"
    source 'default.json.erb'
    owner 'root'
    group 'root'
    mode 0644
  end
 
  template'worker alarm' do
    cookbook 'koop_app_server'
    path "#{deploy[:current_path]}/worker-alarm.sh"
    source 'worker-alarm.sh.erb'
    owner 'root'
    group 'root'
    mode 0744
  end
  
  cron "run_worker_alarm" do
    hour "*"
    minute "*/1"
    weekday "*"
    command "#{deploy[:current_path]}/worker-alarm.sh"
  end

  execute 'stop monit' do
    cwd "/"
    command 'monit stop node_web_app_koop'
    ignore_failure true
  end

  execute 'stop koop' do
    group 'root'
    user 'root'
    cwd "#{deploy[:current_path]}"
    command 'pm2 delete all'
    ignore_failure false
  end

  execute 'start koop' do
    cwd "#{deploy[:current_path]}"
    command "pm2 start server.js"
    ignore_failure false
  end

  #ruby_block "restart node.js application #{application}" do
  #  block do
  #    Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
  #    Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
  #    $? == 0
  #  end
  #end

end
