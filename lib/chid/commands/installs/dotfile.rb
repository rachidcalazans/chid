module Chid
  module Commands
    module Installs
      class Dotfile < Command

        command :'install dotfile'

        self.summary = 'Install the Dotfile'
        self.description = <<-DESC
For Linux users will install through curl and will isntall zsh and git-core

For OSx users will install through curl
        DESC
        self.arguments = []

        def run
          puts "\nInstalling the YADR Dotfiles..."
          ::Chid::on_linux do
            system('sudo apt-get update')
            system('sudo apt-get install curl')
            system('sudo apt-get install zsh')
            system('sudo apt-get install git-core')
          end

          system('sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"')

          puts 'Updating YARD...'
          home_path = File.expand_path("~/")
          path = "#{home_path}/.yadr"
          Dir.chdir path
          system('git pull --rebase')
          system('rake update')

          puts "\nYARD Dotfiles installed successfully"
        end

      end
    end
  end
end
