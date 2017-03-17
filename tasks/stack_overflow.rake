desc 'Search questions in StackOverflow'
task :stack, [:search] do |t, args|

  search_param = args[:search]

  if search_param.nil?
    print "Tell me, what do you want to search?\n".blue
    print "> "
    search_param = STDIN.gets.strip
  end

  question = StackOverflowApi.questions(search_param)

  question.each do |q|
    published_at = q.creation_date.nil? ? 'unkown' : q.creation_date.strftime("%B %d, %Y")
    print "\n"
    print "--- #{q.title} ---".blue
    print "\n"
    print "  Posted #{published_at} by ".brown
    print "\n"
    print "  Link: "
    print "#{q.link}".cyan.underline
    print "\n"
  end

  puts "\n#{StackOverflowApi.current_page} of #{StackOverflowApi.total_pages}"

  if StackOverflowApi.total_pages > 1
    puts "\nPrevious(p) Next(n) Quit(q):"
    print "> "
    option = STDIN.gets
    if (/^q/.match(option))
      StackOverflowApi.reset
    end

    if (/^n/.match(option))
      StackOverflowApi.increase_page_by_1
      task_args = Rake::TaskArguments.new([:search], [search_param])
      Rake::Task['stack'].execute task_args
    end

    if (/^p/.match(option))
      StackOverflowApi.deacrease_page_by_1
      task_args = Rake::TaskArguments.new([:search], [search_param])
      Rake::Task['stack'].execute task_args
    end
  end
end


