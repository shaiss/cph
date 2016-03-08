# capify file from: http://railstips.org/blog/archives/2008/12/14/deploying-rails-on-dreamhost-with-passenger/
require "bundler/capistrano"

# host / user info
if ENV['DH_USER'].nil?
  abort "Need to set env var DH_USER (see README)"
else
  set :user, ENV['DH_USER']
end
set :domain,         'elbert.dreamhost.com'
set :project,        'charlestownplayhouse'
set :project_home,   '/home/cphadmin'
set :application,    'charlestownplayhouse.org'
set :applicationdir, "#{project_home}/#{application}"

# repository / git setup
set :repository,  "#{project_home}/git/#{project}"
set :local_repository, "#{user}@elbert.dreamhost.com:#{project_home}/git/#{project}"
set :scm, 'git'
set :branch, 'master'
## set :git_shallow_clone, 1
set :scm_verbose, true
set :use_sudo, false

## deploy
set :deploy_to, applicationdir
#set :deploy_via, :remote_cache

## bundler setup: note... this only seems to work for the initial bundle
## stuff.. anything using bundle rake fails.  We can use the default
## environment from below to set the correct path.
## set :bundle_cmd, "/home/#{user}/shared/bin/bundle"


## additional options
server domain, :app, :web
role :db, domain, :primary => true
default_run_options[:pty] = true
## pathing info
#default_environment['PATH']="$PATH:/usr/lib/ruby/gems/1.8/bin"

## setup special user stuff
## change the group to the proper cph_dev group.
#after "deploy:update_code", :remove_bad_dirs, :change_group
before "deploy:finalize_update", 'deploy:remove_bad_dirs', 'deploy:change_group'
after "deploy", "deploy:curl"


set :chmod755, "app config db lib public vendor script script/* public/disp*"


namespace :deploy do
  task :start do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :change_group do
    run "chgrp -R cph_dev #{release_path} && echo 'Changing group of #{release_path}'"
  end

  task :remove_bad_dirs do
    run "rm -rf #{release_path}/.git && echo 'Removing .git'"
  end

  task :curl do
    run "curl 'http://www.charlestownplayhouse.org' > /dev/null"
  end
end
