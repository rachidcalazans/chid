# Api Reference: https://newsapi.org/#apiArticles
class NewsApi
  API_TOKEN = 'ce81e7aeb6c4467880b2ee5e4e2d8492'

  Article = Struct.new(:source, :author, :title, :description, :url, :publishedAt)
  Source  = Struct.new(:id, :name, :description, :category)

  SOURCES = [
    :"reddit-r-all",
    :'google-news',
    :'bbc-news',
    :'cnn',
    :'espn',
    :'mashable',
    :techcrunch
  ]

  def self.per_page
    @@per_page ||= 3
  end

  def self.current_source
    @@current_source ||= :'google-news'
  end

  def self.current_page
    @@current_page ||= 1
  end

  def self.total_articles
    @@total_articles ||= 0
  end

  def self.total_pages
    total_articles / per_page
  end

  def self.increase_page_by_1
    @@current_page = @@current_page + 1
  end

  def self.deacrease_page_by_1
    @@current_page = @@current_page - 1
  end

  def self.reset
    @@per_page = nil
    @@current_page = nil
    @@current_source = nil
    @@total_articles = 0
  end

  def self.articles()
    @@total_articles = 0
    sources = self.sources()
    news    = []
    index   = 1
    sources.each do |s|

      request   = HTTP.get("https://newsapi.org/v1/articles?source=#{s.id}&apiKey=#{API_TOKEN}")
      json_news = JSON.parse request

      #puts "ART COUNT: #{json_news[ 'articles' ].count}"
      #puts "TOTAL COUNT: #{total_articles}"


      @@total_articles = total_articles + json_news[ 'articles' ].count

      json_news[ 'articles' ].each do |n|
       # puts "INDEX: #{index} - COUNT NEWS: #{news.count} - PER_PAGE: #{per_page} - CURRENT_PAGE: #{current_page}"
        break if news.count == per_page

        if index >= current_page * per_page
          published_at =  n[ 'publishedAt' ].nil? ? nil : Date.parse(n[ 'publishedAt' ])
          article = Article.new(json_news[ 'source' ], n[ 'author' ], n[ 'title' ],
                      n[ 'description' ], n[ 'url' ], published_at)

          news << article
        end

        index = index + 1
      end

    end
    news.flatten
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
