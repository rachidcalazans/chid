module Chid
  module Commands
    module Installs
      class Vim < Command

        command :'install vim'

        self.summary = 'Install vim'
        self.description = <<-DESC

Usage:
  $ chid install vim

    For Linux users will install through apt-get

    For OSx users will install through brew

        DESC
        self.arguments = []

        def run
          puts "\nInstalling vim..."

          ::Chid::on_linux do
            system('sudo apt-get install vim')
          end

          ::Chid::on_osx do
            system('brew install vim && brew install macvim')
          end

          puts "\nVim installed successfully"
        end
      end
    end
  end
end
