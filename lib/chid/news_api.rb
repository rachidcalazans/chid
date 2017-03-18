# Api Reference: https://newsapi.org/#apiArticles
class NewsApi
  API_TOKEN = 'ce81e7aeb6c4467880b2ee5e4e2d8492'

  Source  = Struct.new(:id, :name, :description, :category)
  Article = Struct.new(:source, :author, :title, :description, :url, :publishedAt) do
    def summary
      published_at = publishedAt.nil? ? 'unkown' : publishedAt.strftime("%B %d, %Y")
      print "\n"
      print "--- #{title} ---".blue
      print "\n"
      print "  Posted #{published_at} by ".brown
      print "#{author}".green
      print "\n\n"
      print "  #{description}"
      print "\n\n"
      print "  Link: "
      print "#{url}".cyan.underline
      print "\n"
    end
  end

  SOURCES = [
    :"reddit-r-all",
    :'google-news',
    :'bbc-news',
    :'cnn',
    :'espn',
    :'mashable',
    :techcrunch
  ]

  def self.articles
    sources = self.sources()
    sources.collect do |s|
      request   = ::HTTP.get("https://newsapi.org/v1/articles?source=#{s.id}&apiKey=#{API_TOKEN}")
      json_news = JSON.parse request

      json_news[ 'articles' ].collect do |n|
          published_at =  n[ 'publishedAt' ].nil? ? nil : Date.parse(n[ 'publishedAt' ])
          Article.new(json_news[ 'source' ], n[ 'author' ], n[ 'title' ],
                      n[ 'description' ], n[ 'url' ], published_at)
      end

    end.flatten
  end

  def self.sources()
    #request      = HTTP.get("https://newsapi.org/v1/sources?language=en")
    #json_sources = JSON.parse request

    #json_sources[ 'sources' ].collect do |s|
    #  Source.new(s[ 'id' ], s[ 'name' ], s[ 'description' ], s[ 'category' ])
    #end
    SOURCES.collect do |s|
      Source.new(s)
    end
  end

end
