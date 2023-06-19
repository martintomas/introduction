set :application, "introduction"
set :repo_url, "https://github.com/martintomas/introduction.git"

set :linked_files, %w[.env]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

set :deploy_to, "/var/www/introduction"

set :rvm_custom_path, "/usr/share/rvm"

set :passenger_restart_with_touch, true

append :linked_files, "config/master.key"

namespace :deploy do
  namespace :check do
    before :linked_files, :set_master_key do
      on roles(:app), in: :sequence, wait: 10 do
        unless test("[ -f #{shared_path}/config/master.key ]")
          upload! 'config/master.key', "#{shared_path}/config/master.key"
        end
      end
    end
  end
end