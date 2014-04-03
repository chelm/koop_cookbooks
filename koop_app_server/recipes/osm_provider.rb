execute 'clone osm provider' do
  cwd "/srv/www/koop/current/api/providers"
  command 'sudo git clone https://github.com/chelm/koop-osm-provider.git'
  ignore_failure false
end

