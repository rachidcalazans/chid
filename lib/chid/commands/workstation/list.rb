module Chid
  module Commands
    module Workstation
      class List < Command

        command :'workstation list'

        self.summary = 'List all existent workstations'
        self.description = <<-DESC

Usage:

  $ chid workstation list

        DESC
        self.arguments = []

        def run
          chid_config = ChidConfig.new
          puts "Workstations availabbe:".blue
          puts chid_config.all_workstations.keys
        end

      end
    end
  end
end
