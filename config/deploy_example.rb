require 'bundler/capistrano'

set :application, "feedback"
#set :domain, 'SOME_DOMAIN'
set :repository,  "REPOSITORY"
set :branch, "master"
set :scm, :git

server "IP_ADDRESS", :app, :web, :db, :primary => true
#or
#role :app, "host1.example.com"
#role :web, "host1.example.com"
#role :db,  "host1.example.com", :primary => true

set :user, "deployer"    
set :deploy_to, "/home/#{user}/webapps/#{application}"
default_environment['PATH']='/usr/local/bin:/usr/bin:/bin:/opt/ruby/bin'
ssh_options[:port] = 38539

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc 'tell passanger to restart the app'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch /www-data/#{application}/tmp/restart.txt"
  end
end


namespace :symlink do
  desc "Symlink shared configs and folders on each release."

  desc "reset symlink to current"
  task :httpdocs do
    run "#{try_sudo} ln -nfs #{current_release} /www-data/#{application}"
  end
  desc "copy local ldap config to server and link it"
  task :ldap do
    upload("config/ldap.yml", "#{shared_path}/config", :via => :scp)
    run "ln -nfs #{shared_path}/config/ldap.yml #{current_release}/config/ldap.yml"
  end
end

# HOOKS
after ["deploy:symlink", "deploy:rollback"] do
  symlink.httpdocs
#  permissions.set_group
end

