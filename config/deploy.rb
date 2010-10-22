require "bundler/capistrano"
require "erb"

set :application, "systemak"
set :user, "rails"
set :db_user, "root"
set :db_password, "mysql1112!"

set :deploy_to, "/home/rails/#{application}/"
set :repository,  "git@github.com:divinecz/systemak.git"
set :scm, :git
set :use_sudo, false
set :port, 8000
set :bundle_cmd, "/opt/ruby/bin/bundle"

role :app, "fs1.sport-butovice.cz"
role :web, "fs1.sport-butovice.cz"
role :db, "fs1.sport-butovice.cz", :primary => true

namespace :passenger do
  desc "Restart the application altering tmp/restart.txt for Passenger."
  task :restart, :roles => :app do
    run "touch  #{current_path}/tmp/restart.txt"
  end
end

namespace :deploy do
  %w(start restart).each { |name| task name, :roles => :app do passenger.restart end }
end

before "deploy:setup", :db
after "deploy:update_code", "db:symlink"
after "deploy:update_code", "daemon:restart"

namespace :db do
  desc "Create database.yaml in shared path."
  task :default do
    db_config = ERB.new <<-EOF
base: &base
  adapter: mysql
  username: #{db_user}
  password: #{db_password}
  encoding: utf8
  socket: /var/run/mysqld/mysqld.sock

development:
  database: #{application}_production
  <<: *base

test:
  database: #{application}_test
  <<: *base

production:
  database: #{application}_production
  <<: *base
EOF
    run "mkdir -p #{shared_path}/config"
    put db_config.result, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database.yaml"
    task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :daemon do
  desc "Start scheduler daemon."
  task :start do
    run "RAILS_ENV=production #{release_path}/bin/scheduler_daemon.rb start"
  end
  
  desc "Stop scheduler daemon."
  task :stop do
    run "RAILS_ENV=production #{release_path}/bin/scheduler_daemon.rb stop"
  end

  desc "Restart scheduler daemon."
  task :restart do
    run "RAILS_ENV=production #{release_path}/bin/scheduler_daemon.rb restart"
  end
end