module Chid
  module Commands
    module Alias
      class Create < Command

        command :'alias create'

        self.summary = 'Create a new alias'
        self.description = <<-DESC

Usage:

  $ chid alias create -command {COMMAND} -alias {ALIAS}

  Example:

  $ chid alias create -command "chid workstation create" -alias cwo

        DESC
        self.arguments = ['-command', '-alias']

        def run
          add_command_on_bashrc

          print "Please run: source ~/.bashrc".blue
        end

        private

        def add_command_on_bashrc
          File.open(bashrc_path, 'a') { |file| file.puts shell_command }
        end

        def bashrc_path
          @bashrc_path ||= File.join(Dir.home, '.bashrc')
        end

        def shell_command
          "alias #{alias_value}='#{command}'"
        end

        def alias_value
          options['-alias'].first
        end

        def command
          options['-command'].first
        end
      end
    end
  end
end

