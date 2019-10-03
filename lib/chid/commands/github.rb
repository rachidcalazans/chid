module Chid
  module Commands
    class Github < Command

      command :'github'

      self.summary = 'List all repositories from GitHub for a given SEARCH'
      self.description = <<-DESC

Usage:

  $ chid github -name rachidcalazans/chid
    or
  $ chid github -n rachidcalazans/chid

    List all repositories from GitHub for a given SEARCH

Options:

  -n NAME_TO_SEARCH
  -name NAME_TO_SEARCH

      DESC
      self.arguments = ['-name', '-n']

      def run
        search_expression = name
        repositories = GitHubApi.repositories(search_expression)

        Paginator.new(repositories).paginate do |repository|
          repository.summary
        end
      end

      def name
        self.class.arguments.map { |a| options[a] }.compact.join(' ')
      end
    end
  end
end
