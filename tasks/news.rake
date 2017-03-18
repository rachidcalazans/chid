desc 'List all news'
task :news do
  articles = NewsApi.articles

  Paginator.new(articles).paginate do |article|
    article.summary
  end

end


