module Chid
  module Commands
    module Workstation
      class Open < Command

        command :'workstation open'

        self.summary = 'Open a specific named workstation'
        self.description = <<-DESC

Usage:

  $ chid workstation open
    or
  $ chid workstation open -name some_workstation_name

    Open all apps listed in the created workstations.

    To see all workstations you can run

      $ chid workstation list

    If no options are specified, chid will show a list of Workstations created
    to be selected.

Options:

  -name workstation_name  Open all applications in the 'workstation_name'
  -n "base two"           Open all applications in the 'base two'

        DESC
        self.arguments = ['-name', '-n']

        def run
          workstation_name = workstation_name_from_options
          workstation_name = select_workstation if workstation_name.empty?

          open_apps(workstation_name)
        end

        private

        # Returns the workstation name mapped from the values of the options attribute.
        # Will remove all nil values and join the array of values into String
        #
        # @return [String] Mapped values from options attribute
        #                  If the options does not exist, will return empty String #=> ""
        #
        # @example Workstation Name
        #   options = {'-name' => ['base', 'two']}
        #
        #   workstation_name #=> 'base two'
        #
        def workstation_name_from_options
          @workstation_name ||= self.class.arguments.map { |a| options[a] }.compact.join(' ')
        end

        def chid_config
          ::Chid.chid_config
        end

        def workstations
          @workstations ||= chid_config.all_workstations
        end

        def select_workstation
          prompt  = TTY::Prompt.new
          choices = workstations.keys.map(&:to_s)
          selected_workstation = prompt.select('Choose a workstation to open', choices)
          selected_workstation
        end

        def open_apps(workstation_name)
          puts "\nOpening all Apps"
          apps = workstations[workstation_name.to_sym]
          apps.each do |app_name|
            chid_config.on_osx do
              system("open -a #{app_name}")
            end

            chid_config.on_linux do
              system("#{app_name} >/dev/null 2>&1 &")
            end
          end
        end

      end
    end
  end
end
