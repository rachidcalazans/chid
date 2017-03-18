class StackOverflowApi

  Question = Struct.new(:title, :creation_date, :link) do
    def summary
      published_at = creation_date.nil? ? 'unkown' : creation_date.strftime("%B %d, %Y")
      print "\n"
      print "--- #{title} ---".blue
      print "\n"
      print "  Posted #{published_at} by ".brown
      print "\n"
      print "  Link: "
      print "#{link}".cyan.underline
      print "\n"
    end
  end

  def self.questions(search)
    uri          = URI("https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=#{search}&site=stackoverflow")
    response     = HTTP.get(uri)
    body_decoded = decode_body(response.body.to_s)
    json_news    = JSON.parse(body_decoded)

    json_news[ 'items' ].collect do |i|
      Question.new(i['title'], Time.at(i[ 'creation_date' ]), i['link'])
    end

  end

  private
  def self.decode_body(body_str)
    gz = Zlib::GzipReader.new(StringIO.new(body_str))
    gz.read
  end

end
