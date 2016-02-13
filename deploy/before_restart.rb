node[:deploy].each do |application, deploy|
  next unless application.to_s == 'deployments-dashboard' || application.to_s == 'deployments_dashboard'
  Chef::Log.info("application name #{application}")
  release_dir = ::File.expand_path(__FILE__).sub('deploy/before_restart.rb', '')
  Chef::Log.info("release_dir: #{release_dir}")
  user = deploy[:user]
  group = deploy[:group]
  rails_env = deploy[:custom_env_vars][:RACK_ENV]

  execute 'Ensuring bundle is installed without test and development gems, jobs = 2' do
    cwd release_dir
    command 'bundle install --without development test --jobs 2'
  end

  execute "Precompiling assets for env: #{rails_env}" do
    cwd release_dir
    command "RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end

  execute "Ensuring app log is owned by #{user}:#{group}" do
    cwd ::File.join(release_dir, 'log')
    command "sudo chown #{user}:#{group} #{rails_env}.log"
  end
end
