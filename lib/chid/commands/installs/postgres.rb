module Chid
  module Commands
    module Installs
      class Postgres < Command

        command :'install postgres'

        self.summary = 'Install the Postgres'
        self.description = <<-DESC

Usage:

  $ chid install postgres

    For Linux users will install through apt-get

    For OSx users will install through brew

        DESC
        self.arguments = []



        def run
          puts "\nInstalling the Postgres..."

          ::ChidConfig.on_linux do
            system('sudo apt update')
            system('sudo apt install postgresql postgresql-contrib')
            system('sudo apt-get install libpq-dev')
          end

          ::ChidConfig.on_osx do
            system('brew update')
            system('brew install postgres')
          end

          puts "\nPostgres installed successfully"
        end

      end
    end
  end
end
