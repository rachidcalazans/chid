desc 'Search questions in StackOverflow'
task :stack, [:search] do |t, args|

  search_param = args[:search]

  unless search_param
    print "Tell me, what do you want to search?\n".blue
    print "> "
    search_param = STDIN.gets.strip
  end

  questions = StackOverflowApi.questions(search_param)

  Paginator.new(questions).paginate do |question|
    question.summary
  end

end


