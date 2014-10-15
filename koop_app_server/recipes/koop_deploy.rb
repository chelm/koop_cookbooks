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

  execute 'install gist' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-gist/tarball/master'
    ignore_failure false
  end

  execute 'install github' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-github/tarball/master'
    ignore_failure false
  end
  
  execute 'install socrata' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-socrata/tarball/master'
    ignore_failure false
  end

  execute 'install agol' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/Esri/koop-agol/tarball/master'
    ignore_failure false
  end

  execute 'install geocommons' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-geocommons/tarball/master'
    ignore_failure false
  end

  execute 'install climate' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-climate/tarball/master'
    ignore_failure false
  end

  execute 'install vrbo' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-vrbo/tarball/master'
    ignore_failure false
  end

  execute 'install osm' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-osm/tarball/master'
    ignore_failure false
  end

  execute 'install cloudant' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/cloudant/koop-cloudant/tarball/master'
    ignore_failure false
  end

  execute 'install acs' do
    cwd "#{deploy[:current_path]}"
    command 'sudo npm install https://github.com/chelm/koop-acs/tarball/master'
    ignore_failure false
  end

  ruby_block "restart node.js application #{application}" do
    block do
      Chef::Log.info("restart node.js via: #{node[:deploy][application][:nodejs][:restart_command]}")
      Chef::Log.info(`#{node[:deploy][application][:nodejs][:restart_command]}`)
      $? == 0
    end
  end

  template 'github config.js' do
    cookbook 'koop_app_server'
    path "#{deploy[:current_path]}/node_modules/koop-github/models/config.js"
    source 'ghconfig.js.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

  template 'gist config.js' do
    cookbook 'koop_app_server'
    path "#{deploy[:current_path]}/node_modules/koop-gist/models/config.js"
    source 'ghconfig.js.erb'
    owner 'root'
    group 'root'
    mode 0644
  end
  
end
