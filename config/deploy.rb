set :application, "testapp"
set :repository,  "<git repo url>"
set :deploy_to, "/var/www/html/testrepo/testapp"
set :document_root, "/var/www/html/testrepo/current"
set :port, 30000

set :scm, :git
set :scm_username, "<git username>"
set :scm_password, "<git password>"
set :scm_checkout, "clone"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "<user>"
#set :password, "<password>"
set :use_sudo, false
#set :ssh_options, {:forward_agent => true}
ssh_options[:forward_agent] = true

#default_run_options[:pty] = true 


role :web, "<Destination IP>"                          # Your HTTP server, Apache/etc
role :app, "<Destination IP>"                          # This may be the same as your `Web` server
role :db,  "<Destination IP>", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
namespace :deploy do
	task :update do
		transaction do
			update_code
			symlink
		end
	end
	
	task :finalize_update do
		transaction do			
		end
	end
	
	task :symlink do
		transaction do
			run "ln -nfs #{current_release} #{deploy_to}/#{current_dir}"
			run "ln -nfs #{deploy_to}/#{current_dir} #{document_root}"
		end
	end

	task :migrate do
	end

	task :restart do
	end
end
