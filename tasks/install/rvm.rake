namespace :install do

  desc 'Install RVM'
  task :rvm do
    puts "\nInstalling the RVM..."

    @chid_config.on_linux do
      system('sudo apt-add-repository -y ppa:rael-gc/rvm')
      system('sudo apt-get update')
      system('sudo apt-get install curl')
      system('sudo apt-get install rvm')
    end

    @chid_config.on_osx do
      system('\curl -sSL https://get.rvm.io | bash')
    end

    puts "\nRVM installed successfully"
  end

end
