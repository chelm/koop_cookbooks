include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  directory node[:koop][:data_dir] do
    mode 0755
    action :create
  end

end
