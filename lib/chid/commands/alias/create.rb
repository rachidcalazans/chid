module Chid
  module Commands
    module Alias
      class Create < Command

        command :'alias create'

        self.summary = 'Create a new alias'
        self.description = <<-DESC

Usage:

  # @todo - REDO USAGE DESC
  $ chid alias create -command {COMMAND} -alias {ALIAS}

        DESC
        self.arguments = ['-command', '-alias']

        def run
          command     = options['-command'].first
          alias_value = options['-alias'].first

          bash_file = File.open(bashrc_path, 'a') do |file|
            file.puts "alias #{alias_value}='#{command}'"
          end

          print "Please run: source ~/.bashrc".blue

          true
        end

        private

        def bashrc_path
          @bashrc_path ||= File.join(Dir.home, '.bashrc')
        end
      end
    end
  end
end

