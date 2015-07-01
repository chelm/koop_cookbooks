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

  template 'worker alarm' do
    cookbook 'koop_agol_workers'
    path "/koop-agol/workers/worker-alarm.sh"
    source 'worker-alarm.sh.erb'
    owner 'root'
    group 'root'
    mode 0744
  end
  
  cron "run_worker_alarm" do
    hour "*"
    minute "*/1"
    weekday "*"
    command "/koop-agol/workers/worker-alarm.sh"
  end

  #ruby_block "restart node.js application #{application}" do
  #  block do
  #    Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
  #    Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
  #    $? == 0
  #  end
  #end

end
