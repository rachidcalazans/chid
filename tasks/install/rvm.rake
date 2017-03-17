namespace :install do

  desc 'Install RVM'
  task :rvm do
    puts "\nInstalling the RVM..."

    @chid_config.on_linux do
      system('sudo apt-get install curl')
    end

    system('\curl -sSL https://get.rvm.io | bash')

    puts "\nRVM installed successfully"
  end

end
