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
          prompt = TTY::Prompt.new
          choices = ['Add', 'Remove','Update', 'Refactor','Fix']
          result = prompt.select('Select the kind of commit:', choices)
          puts 'This is a commit of type ' + result

          puts 'Tell me the title of this commit'
          print "> "
          commit_title = STDIN.gets.strip

          puts 'Tell me the commit description, 140 characteres per line'
          print "> "
          commit_description = '- ' + STDIN.gets.strip

          answers = ['Yes','No']
          result_tests_question = prompt.select('Have tests?', answers)
          puts commit_description
        end

      end
    end
  end
end
