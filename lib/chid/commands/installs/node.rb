module Chid
  module Commands
    module Installs
      class Node < Command

        command :'install node'

        self.summary = 'Install the Node'
        self.description = <<-DESC

Usage:

  $ chid install node

    For Linux users will install through apt-get

    For OSx users will install through brew

        DESC
        self.arguments = []

        def run
          puts "\nInstalling the Node..."

          ::Chid::on_linux do
            system('sudo apt-get install nodejs')
          end

          ::Chid::on_osx do
            system('brew install node')
          end

          puts "\nNode installed successfully"
        end

      end
    end
  end
end
