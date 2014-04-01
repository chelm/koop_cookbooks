execute 'npm install -g grunt-cli forever' do
  command 'git clone https://github.com/chelm/koop-osm-provider.git /srv/www/koop/current/api/providers/koop_osm_provider'
  action :nothing
end

template 'config.js' do
  cookbook 'koop_osm_provider'
  path "/srv/www/koop/current/api/providers/koop_osm_provider/models/config.js"
  source 'config.js.erb'
  owner 'root'
  group 'root'
  mode 0644
end
