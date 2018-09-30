module Chid
  module Commands
    module Workstation
      class Destroy < Command

        command :'workstation destroy'

        self.summary = 'Destroy a specific workstation'
        self.description = <<-DESC

Usage:

  $ chid workstation destroy

    Destroy a specific workstation with the selected name.

    To see all workstations you can run

      $ chid workstation list

        DESC
        self.arguments = []

        def run
          result = select_workstations

          if result.empty?
            puts "\nYou did not select any Workstation, please try again."
            return
          end

          chid_config.destroy_workstations(result)

          puts "\nWorkstations removed!"
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

        def select_workstations
          prompt = TTY::Prompt.new
          workstations = chid_config.all_workstations
          choices = workstations.keys.map(&:to_s)

          prompt
            .multi_select('Select all workstations to destroy', choices)
            .map(&:to_sym)
        end
      end
    end
  end
end
