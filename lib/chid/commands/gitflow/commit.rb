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
          commit = build_commit 
          puts commit
          #system("git commit -sm \"#{commit}\"")
        end

        def build_commit 
          @commit_lines = "\n"
          commit_kind  = add_commit_kind
          commit_title = add_commit_title
          add_commit_description
          commit = "#{commit_kind} #{commit_title} \n #{@commit_lines}"
        end

        def add_commit_kind
          @prompt = TTY::Prompt.new
          choices = ['Add', 'Remove','Update', 'Refactor','Fix'] #TODO: look for commit patterns and add description for each
          result = @prompt.select('Select commit type: ', choices)
        end

        def add_commit_title
          puts 'Tell me the commit title'
          print '> '
          commit_title = STDIN.gets.strip
        end

        def add_commit_description
          puts 'Tell me the commit description, one action per line'
          print "> "
          commit_description ="- #{STDIN.gets.strip} \n"
          @commit_lines << commit_description
          add_commit_description unless did_commit_finished?
        end

        def did_commit_finished?
          answers = ['Yes','No']
          result_description_finished = @prompt.select('more?', answers)
          result_description_finished == 'No'
        end

      end
    end
  end
end
