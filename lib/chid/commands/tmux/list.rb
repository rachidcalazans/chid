module Chid
  module Commands
    module Tmux
      class List < Command

        command :'tmux list'

        self.summary = 'List all existent tmux template'
        self.description = <<-DESC

Usage:

  $ chid tmux list

        DESC
        self.arguments = []

        def run
          chid_config = ChidConfig.new
          puts "Tmux templates availabbe:".blue
          puts chid_config.all_tmux_templates.keys
        end

      end
    end
  end
end

