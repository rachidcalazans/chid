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
          system("git commit -sm \"#{commit}\"")
          system("git push origin #{branch}")
        end

        def build_commit
          @commit_lines = "\n"
          commit_kind  = add_commit_kind
          commit_title = add_commit_title
          add_commit_description
          commit = "#{branch_name} #{commit_kind} #{commit_title} \n #{@commit_lines}"
        end

        def branch
          @branch ||= %x[git rev-parse --abbrev-ref HEAD].strip
        end

        def branch_name
          @branch_name ||= branch[/\w{1,}\/#?\d{1,}/] || branch
        end

        def add_commit_kind
          @prompt = TTY::Prompt.new
          choices = ['Add', 'Remove','Update', 'Refactor','Fix']
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

        def do_push?
          answers = ['Yes','No']
          result_should_push = @prompt.select('Push changes?', answers)
          result_should_push == 'Yes'
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
