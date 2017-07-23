module Chid
  module Commands
    module Installs
      class Node < Command

        self.summary = 'Install the Node'
        self.description = <<-DESC
          For Linux users will install through apt-get

          For OSx users will install through bew
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
