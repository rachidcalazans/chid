module Chid
  module Commands
    module Installs
      class Node

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
