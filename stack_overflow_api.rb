require 'zlib'
require 'stringio'
require 'http'

class StackOverflowApi 

    Question = Struct.new(:title, :creation_date, :link)

    def self.per_page
        @@per_page ||= 3
    end

     def self.current_page
        @@current_page ||= 1
    end

    def self.total_questions
        @@total_questions ||= 0
    end

    def self.total_pages
        total_questions / per_page
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
        @@total_questions = 0
    end

    def self.questions(search)
        @@total_questions = 0
        list_questions = []
        index = 1
        uri = URI("https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=#{search}&site=stackoverflow")
        request = HTTP.get(uri)
        gz = Zlib::GzipReader.new(StringIO.new(request.body.to_s))        
        body_decoded = gz.read
        json_news = JSON.parse(body_decoded)

        @@total_questions = total_questions + json_news[ 'items' ].count

        json_news[ 'items' ].each do |i|
            break if list_questions.count == per_page
            if index >= current_page * per_page 
                question = Question.new(i['title'], Time.at(i[ 'creation_date' ]), i['link'])
                list_questions << question
            end
            index = index + 1
        end

        list_questions.flatten
    end
end