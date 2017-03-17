require './news_api'

desc 'List all news'
task :news do
  articles = NewsApi.articles

  articles.each do |a|
    published_at = a.publishedAt.nil? ? 'unkown' : a.publishedAt.strftime("%B %d, %Y")
    print "\n"
    print "--- #{a.title} ---".blue
    print "\n"
    print "  Posted #{published_at} by ".brown
    print "#{a.author}".green
    print "\n\n"
    print "  #{a.description}"
    print "\n\n"
    print "  Link: "
    print "#{a.url}".cyan.underline
    print "\n"
  end

  puts "\n#{NewsApi.current_page} of #{NewsApi.total_pages}"

  if NewsApi.total_pages > 1
    puts "\nPrevious(p) Next(n) Quit(q):"
    print "> "
    option = STDIN.gets
    if (/^q/.match(option))
      NewsApi.reset
    end

    if (/^n/.match(option))
      NewsApi.increase_page_by_1
      Rake::Task['news'].execute
    end

    if (/^p/.match(option))
      NewsApi.deacrease_page_by_1
      Rake::Task['news'].execute
    end
  end
end


