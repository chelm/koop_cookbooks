include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  execute 'rake assets:precompile' do
    cwd deploy[:current_path]
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => 'production'
  end
end
