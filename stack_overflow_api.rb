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
        @@SEARCH_QUESTION = "No provider for NavController"
        @@total_questions = 0
        questions = []
        index = 1

        request   = HTTP.get("http://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=#{SEARCH_QUESTION}&site=stackoverflow")
        json_news = JSON.parse request

        @@total_questions = total_articles + json_news[ 'items' ].count

        json_news[ 'items' ].each do |i|
            if index >= current_page * per_page
                published_at = i['creation_date'].nil ? nil : Date.parse(i[ 'creation_date' ])
                question = Question.new(i['title'], published_at, i['link'])
                questions << question
            end
            index = index + 1
        end

        question.flatten
    end
end