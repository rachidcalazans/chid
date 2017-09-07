module Chid
  module Commands
    class StackOverflow < Command

      command :'stack'

      self.summary = 'Will search on StackOverflow all results'
      self.description = <<-DESC

Usage:

  $ chid stack
    or
  $ chid stack -s some_text_to_be_searched

    Will search on StackOverflow all results

    If no pass option Will ask what you want to search on StackOverflow all results for the passed text

Options:

  -search TEXT_TO_SEARCH
  -s TEXT_TO_SEARCH

      DESC
      self.arguments = ['-search', '-s']

      def run
        text_to_search = text_to_search_from_options
        text_to_search = get_text_to_search if text_to_search.empty?

        questions = ::StackOverflowApi.questions(text_to_search)
        ::Paginator.new(questions).paginate { |question| question.summary }
      end

      private

      def get_text_to_search
          print "Tell me, what do you want to search?\n".blue
          print "> "
          STDIN.gets.strip
        end



      # Returns the TEXT_TO_SEARCH mapped from the values of the options attribute.
      # Will remove all nil values and join the array of values into String
      #
      # @return [String] Mapped values from options attribute
      #                  If the options does not exist, will return empty String #=> ""
      #
      # @example Text to Search
      #   options = {'-search' => ['base', 'two']}
      #
      #   text_to_search #=> 'base two'
      #
      def text_to_search_from_options
        @text_to_search ||= self.class.arguments.map { |a| options[a] }.compact.join(' ')
      end

    end
  end
end
