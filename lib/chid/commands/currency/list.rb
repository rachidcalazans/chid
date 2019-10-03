module Chid
  module Commands
    module Currency
      class List < Command

        command :'currency list'

        self.summary = 'All list of available Source to use on `now` and `convert commands`'
        self.description = <<-DESC

Usage:

  $ chid currency list

    All list of available Source to use on `now` and `convert commands`

    To get current value, please run `chid currency now`

    To convert some value, please run `chid currency convert `

Options:

      DESC
      self.arguments = []

        def run
          types = CurrencyApi::SOURCES
          puts "Types available:\n\n"
          types.each { |k, v| puts "#{k} => #{v}"}
        end
      end
    end
  end
end
