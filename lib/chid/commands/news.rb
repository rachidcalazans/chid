module Chid
  module Commands
    class News < Command

      command :'news'

      self.summary = 'Will show all news from some sites'
      self.description = <<-DESC

Usage:

  $ chid news

    Will show all news from some sites

    Sites:
      BBC, CNN, Espn, Mashable, Google, Techcrunch, Reddit


Options:

      DESC
      self.arguments = []

      def run
        articles = ::NewsApi.articles
        ::Paginator.new(articles).paginate { |article| article.summary }
      end

    end
  end
end
