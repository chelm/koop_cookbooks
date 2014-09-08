include_recipe 'apt'

apt_repository 'apt.postgresql.org' do
  components ['main']
  distribution "#{node['lsb']['codename']}-pgdg"
  key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
  notifies :run, 'execute[apt-get update]', :immediately
  uri 'http://apt.postgresql.org/pub/repos/apt'
end

execute 'add-apt-repo' do
  command 'add-apt-repository ppa:ubuntugis/ppa'
  ignore_failure true
end

execute 'apt-get-update' do
  command 'apt-get update'
  ignore_failure true
end

#ppa "ppa:ubuntugis/ppa"
#sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update

package 'zip'
package 'gdal-bin'
package 'pkg-config'
package 'libcairo2-dev'
package "pgdg-keyring"
package 'libgdal-dev'
package 'libpq-dev'
package 'postgresql-9.3'
package 'postgresql-client-9.3'
package 'postgresql-server-dev-all'
