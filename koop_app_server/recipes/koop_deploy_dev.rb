include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::koop application #{application} as it is not a Node app (its of type #{deploy[:application_type]})")
    next
  end

  directory node[:koop][:data_dir] do
    mode 0755
    action :create
  end

  template 'default.json' do
    cookbook 'koop_app_server'
    path "#{deploy[:current_path]}/config/default.json"
    source 'default_dev.json.erb'
    owner 'root'
    group 'root'
    mode 0644
  end
  
end
