include_recipe 'deploy'

execute 'npm install -g grunt-cli forever' do
  command 'sudo npm install -g grunt-cli forever'
  ignore_failure false
end

directory node[:koop][:data_dir] do
  mode 0755
  action :create
end

node[:deploy].each do |application, deploy|
  template 'defaul.yml' do
    cookbook 'koop_app_server'
    path "/srv/www/koop/current/config/default.yml"
    source 'default.yml.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

  execute 'install gist' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-gist/tarball/master'
    ignore_failure false
  end

  execute 'install github' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-github/tarball/master'
    ignore_failure false
  end
  
  execute 'install socrata' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-socrata/tarball/master'
    ignore_failure false
  end

  execute 'install agol' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-agol/tarball/master'
    ignore_failure false
  end

  execute 'install geocommons' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-geocommons/tarball/master'
    ignore_failure false
  end

  execute 'install climate' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-climate/tarball/master'
    ignore_failure false
  end

  execute 'install vrbo' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-vrbo/tarball/master'
    ignore_failure false
  end

  execute 'install osm' do
    cwd "/srv/www/koop/current"
    command 'sudo npm install https://github.com/chelm/koop-osm/tarball/master'
    ignore_failure false
  end
end
