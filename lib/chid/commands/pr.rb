module Chid
  module Commands
    class Pr < Command

      command :'pr'

      self.summary = "Will return a list of Open PR's filters by given user"
      self.description = <<-DESC

Usage:

  $ chid pr

  or

  $ chid pr -user rachidcalazans


Options:

  -user

      DESC
      self.arguments = ['-user']

      def run
        json_prs = GitHubApi.prs(by: user)
        msg      = build_msg(json_prs)

        send_msg(msg)

        msg
      end

      private

      def user
        options['-user']&.first
      end

      def build_msg(json_prs)
        json_prs
          .filter { |pr| pr['user']['login'] == user }
          .each_with_object([]) do |pr, memo|
          pr.transform_keys!(&:to_sym)
          pr[:user].transform_keys!(&:to_sym)

          memo << <<~STR
            ##{pr[:number]} - #{pr[:title]}
            By #{pr[:user][:login]}
            Status: #{pr[:state]}
            Labels: #{pr[:labels].map { |label| label['name'] }.join(', ') }
          STR
        end.join("\n---\n\n")
      end


      def send_msg(msg)
        puts msg
      end
    end
  end
end
