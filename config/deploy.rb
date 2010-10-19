set :application, "capistrano_example"
set :user, 'kmahan'
set :ssh_options, { :forward_agent => true }
set :deploy_to, "/home/#{user}/apps/#{application}"



set :scm, :git
set :branch, "master"
set :repository,  "git://github.com/KellyMahan/capistrano_example.git"

set :rake, "/usr/local/rvm/gems/ruby-1.9.2-p0/bin/rake"
#default_environment["PATH"] = "/usr/local/rvm/rubies/ruby-1.9.2-p0/bin/ruby:/usr/local/bin:./"

role :app, "192.168.1.54" # This may be the same as your `Web` server
role :db,  "192.168.1.54", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"


set :deploy_via, :remote_cache
set :keep_releases, 10


default_run_options[:pty] = true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end