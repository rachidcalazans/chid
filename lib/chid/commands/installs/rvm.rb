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
          system('gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB')

          ::ChidConfig.on_linux do
            system('sudo apt-get install software-properties-common')
            system('sudo apt-get install curl')
            system('sudo apt-add-repository -y ppa:rael-gc/rvm')
            system('sudo apt-get update')
            system('sudo apt-get install rvm')

            system("echo 'source \"/etc/profile.d/rvm.sh\"' >> ~/.bashrc")
          end

          ::ChidConfig.on_osx do
            system('\curl -sSL https://get.rvm.io | bash -s stable --ruby')
          end

          puts "\nRVM installed successfully"
          puts "\nPlease rebot your terminal"
        end

      end
    end
  end
end
