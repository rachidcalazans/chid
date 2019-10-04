module Chid
  module Commands
    module Installs
      class Rvm < Command

        command :'install rvm'

        self.summary = 'Install the RVM'
        self.description = <<-DESC

Usage:

  $ chid install rvm

    For Linux users will install through apt-get

    For OSx users will install through curl

        DESC
        self.arguments = []


        def run
          puts "\nInstalling the RVM..."

          ::ChidConfig.on_linux do
            system('sudo apt-add-repository -y ppa:rael-gc/rvm')
            system('sudo apt-get update')
            system('sudo apt-get install curl')
            system('sudo apt-get install rvm')
          end

          ::ChidConfig.on_osx do
            system('\curl -sSL https://get.rvm.io | bash')
          end

          puts "\nRVM installed successfully"
        end

      end
    end
  end
end
