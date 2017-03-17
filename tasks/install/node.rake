namespace :install do

  desc 'Install Node'
  task :node do
    puts "\nInstalling the Node..."

    @chid_config.on_linux do
      system('sudo apt-get install nodejs')
    end

    @chid_config.on_osx do
      system('brew install node')
    end

    puts "\nNode installed successfully"
  end

end
