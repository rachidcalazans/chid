# @todo: Extract it for a Command feature
namespace :install do

  desc 'Install YADR Dotfiles'
  task :dotfiles do
    puts "\nInstalling the YADR Dotfiles..."
    @chid_config.on_linux do
      system('sudo apt-get update')
      system('sudo apt-get install curl')
      system('sudo apt-get install zsh')
      system('sudo apt-get install git-core')
    end

    system('sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"')

    puts 'Updating YARD...'
    path = "#{@chid_config.home_path}/.yadr"
    Dir.chdir path
    system('git pull --rebase')
    system('rake update')

    puts "\nYARD Dotfiles installed successfully"
  end

end


