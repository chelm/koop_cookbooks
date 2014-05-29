execute 'clone osm provider' do
  command 'sudo git clone https://github.com/chelm/koop-osm.git /srv/www/koop/current/node_modules/koop-osm'
  not_if { ::File.directory?("/srv/www/koop/current/node_modules/koop-osm") }
end

template 'config.js' do
  cookbook 'koop_osm_provider'
  path "/srv/www/koop/current/node_modules/koop-osm/models/config.js"
  source 'config.js.erb'
  owner 'root'
  group 'root'
  mode 0644
end
