module Chid
  module Commands
    module Installs
      class Postgres

        def run
          puts "\nInstalling the Postgres..."

          ::Chid::on_linux do
            system('sudo apt-get install postgresql postgresql-contrib')
          end

          ::Chid::on_osx do
            system('brew install postgres')
          end

          puts "\nPostgres installed successfully"
        end

      end
    end
  end
end
