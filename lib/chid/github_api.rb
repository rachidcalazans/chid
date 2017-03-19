# Api Reference: https://developer.github.com/v3/search/#search-repositories
class GitHubApi
 
  Owner = Struct.new(:login)

  Repository = Struct.new(:name, :owner, :html_url, :clone_url, :language, :stargazers_count, :updated_at) do
    def summary
      last_activity = updated_at.nil? ? 'unkown' : updated_at.strftime('%a %d %b %Y')
      print "\n"
      print "--- Repo name -> #{name} ---"
      print "\n\n"      
      print "Author #{owner.login}".gray.bold
      print "\n\n"
      print "Link:\t".gray
      print "#{html_url}".cyan.underline
      print "\n\n"
      print "Link to clone:\t".gray      
      print "#{clone_url}".cyan.underline
      print "\n\n"            
      print "Write in #{language}".green.bold
      print "\n\n"
      print "Stars #{stargazers_count}".cyan.bold
      print "\n\n"
      print "Last activity #{last_activity}"
      print "\n\n"      
    end
  end

  def self.repositories(search_expression)
      uri = URI("https://api.github.com/search/repositories?q=#{search_expression}&sort=stars&order=desc")
      request = ::HTTP.get(uri)
      json_repositories = JSON.parse request

      json_repositories['items'].collect do |item|
        updated_at = item['updated_at'].nil? ? nil : Date.parse(item['updated_at'])
        owner = Owner.new(item['owner']['login'])
        Repository.new(item['name'], owner, item['html_url'], item['clone_url'], item['language'],
                        item['stargazers_count'], updated_at)
      end
  end
end
