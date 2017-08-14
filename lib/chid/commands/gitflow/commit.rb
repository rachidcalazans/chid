module Chid
  module Commands
    module Gitflow
      class Commit < Command

        command :commit
        self.summary = 'Will commit a...'
        self.description = <<-DESC
        DESC
        self.arguments = []

        def run
          @prompt = TTY::Prompt.new
          choices = ['Add', 'Remove','Update', 'Refactor','Fix']
          result = @prompt.select('Select the kind of commit:', choices)
          puts 'Tell me the commit title'
          print '> '
          commit_title = STDIN.gets.strip
          @commit_lines = "\n"
          add_commit_description
          commit = "#{result} #{commit_title} \n #{@commit_lines}"
          system("git commit -sm \"#{commit}\"")
        end

        def add_commit_description
          puts 'Tell me the commit description, 140 characteres per line'
          print "> "
          commit_description ="- #{STDIN.gets.strip} \n"
          @commit_lines << commit_description
          unless did_commit_finished?
            add_commit_description
          end
        end

        def did_commit_finished?
          answers = ['Yes','No']
          result_description_finished = @prompt.select('Did you finish?', answers)
          result_description_finished == 'Yes'
        end

      end
    end
  end
end
