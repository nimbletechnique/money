set :application, "money"
set :user, "collin"
set :host, "#{user}@gluedtomyseat.com"
set :checkout, "export"
set :repository,  "svn+ssh://#{host}/usr/local/svn/repo/money"

set :deploy_to, "/home/#{user}/web/rails/#{application}"

set :scm, :subversion
set :scm_username, user
set :runner, user

role :app, "#{host}"
role :web, "#{host}"
role :db,  "#{host}", :primary => true

after 'deploy:symlink' do
  run "cp #{deploy_to}/shared/database.yml #{deploy_to}/current/config"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

