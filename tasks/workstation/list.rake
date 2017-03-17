namespace :workstation do

  desc 'List all workstations'
  task :list do
    puts "Workstations availabbe:".blue
    puts @chid_config.all_workstations.keys
  end

end

