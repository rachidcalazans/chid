module Chid
  module Commands
    module Workstation
      class Create < Command

        command :'workstation create'

        self.summary = 'Create a new workstation'
        self.description = <<-DESC

Usage:

  $ chid workstation create

    Create a a new workstation with the selected apps.

    To see all workstations you can run

      $ chid workstation list

        DESC
        self.arguments = []

        def run
          workstation_name = get_workstation_name 
          result           = chid_config.on_osx { select_apps_on_osx }

          if result.empty?
            puts "\nYou did not select any App, please try again."
            return
          end

          chid_config.create_workstation(workstation_name, result)

          puts "\n#{workstation_name} workstation was created!"
        end

        private

        def get_workstation_name
          puts 'tell me the name of the new workstation'
          print "> "
          STDIN.gets.strip
        end

        def chid_config
          ::Chid.chid_config
        end

        def select_apps_on_osx
          prompt = TTY::Prompt.new

          choices = %x{ls /applications}.strip
          choices = choices
            .gsub(/\n/, ' - ')
            .gsub('.app', '')
            .split(' - ')
          prompt.multi_select('select all apps for that workstation?', choices)
        end
      end
    end
  end
end
