module Chid
  module Commands
    module Workstation
      class Create < Command

        command :'workstation create'

        self.summary = 'Create a new workstation'
        self.description = <<-DESC

Usage:

  $ chid workstation create

    Create a new workstation with the selected apps.

    # @todo - Add description to use with new arguments

    To see all workstations you can run

      $ chid workstation list

        DESC
        self.arguments = ['-name', '-app_names']

        def run
          workstation_name = get_workstation_name
          result           = ::ChidConfig.on_osx { select_apps_on_osx }

          if result.empty?
            puts "\nYou did not select any App, please try again."
            return
          end

          chid_config.create_workstation(workstation_name, result)

          puts "\n#{workstation_name} workstation was created!"
        end

        private

        def get_workstation_name
          return option_name if option_name

          puts 'tell me the name of the new workstation'
          print "> "
          STDIN.gets.strip
        end

        def option_name
          options['-name']&.first&.strip
        end

        def option_app_names
          options['-app_names']
        end

        def chid_config
          ::ChidConfig.new
        end

        def select_apps_on_osx
          prompt = TTY::Prompt.new

          choices = osx_application_names

          default_choices = default_choices(choices)

          prompt.multi_select('select all apps for that workstation?', choices, default: default_choices)
        end


        def osx_application_names
          osx_application_names = %x{ls /applications}.strip

          osx_application_names
            .gsub(/\n/, ' - ')
            .gsub('.app', '')
            .split(' - ')
        end

        def default_choices(choices)
          return unless option_app_names

          choices
            .flatten
            .each_with_object([])
            .each_with_index do |(choice, memo), index|
              memo << index + 1 if option_app_names.include?(choice)
          end
        end
      end
    end
  end
end
