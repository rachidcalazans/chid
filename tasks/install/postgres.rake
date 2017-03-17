namespace :install do

  desc 'Install Postgres'
  task :postgres do
    puts "\nInstalling the Postgres..."

    @chid_config.on_linux do
      system('sudo apt-get install postgresql postgresql-contrib')
    end

    @chid_config.on_osx do
      system('brew install postgres')
    end

    puts "\nPostgres installed successfully"
  end

end
