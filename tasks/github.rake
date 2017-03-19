desc 'List all repositories'
task :github, [:search] do |t, args|
  search_expression = args[:search]

  repositories = GitHubApi.repositories(search_expression)

  Paginator.new(repositories).paginate do |repository|
    repository.summary
  end
end


