# @todo: Extract it for a Command feature
namespace :update do

  desc 'Update os'
  task :os do
    @chid_config.on_linux do
      system('sudo apt-get update && sudo apt-get -y upgrade')
    end

    @chid_config.on_osx do
      puts "Sorry I can't update the OSx"
    end
  end

end
