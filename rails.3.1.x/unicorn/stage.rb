#---------------------------
# Load deployment tasks for Asset Pipeline
# This will run deploy:assets:precompile on the remote server
#---------------------------
load 'deploy/assets'

#---------------------------
# Git branch to deploy
#---------------------------
set :branch, "production"

#---------------------------
# Set variables for deployment
#---------------------------
set :user, "youruser"
set :app, "yourapp"

#---------------------------
# Using rbenv so add it to capistrano's shell
# Assumptions here
# * rbenv has been installed under the user you are deploying as
#---------------------------
set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH"
}

#---------------------------
# Where are we deploying?
#---------------------------
server "yourserver.com", :app, :web, :db, :primary => true
set :deploy_to, "/srv/yourapp" 

#---------------------------
# Bundler options. We use this to separate the devops from the app
# So we can upgrade version of Ruby easily
#---------------------------
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

#---------------------------
# Assumptions here
# * Monit is being used to restart services like sphinx
# * You have a script in init.d to handle unicorn
#---------------------------
namespace :deploy do
  task :start do
    sudo "/usr/sbin/monit -g #{app} start all"
    sudo "/etc/init.d/#{app} start"
  end

  task :stop do
    sudo "/usr/sbin/monit -g #{app} stop all"
    sudo "/etc/init.d/#{app} stop"
  end

  task :restart do
    sudo "/usr/sbin/monit -g #{app} restart all"
    sudo "/etc/init.d/#{app} upgrade"
  end

  task :link_config_files do
    run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/#{shared_dir}/tmp/sockets #{release_path}/tmp/sockets"
  end
end

before "deploy:assets:precompile", "deploy:link_config_files"

