module Chid
  module Commands
    module Currency
      class Current < Command

        command :'currency now'

        self.summary = 'Get the now converstion. Default -from USD -to BRL'
        self.description = <<-DESC

Usage:

  $ chid currency now
    or
  $ chid currency now -to BRL -from USB

    Get the now converstion. Default -from USD -to BRL

    But you can given the options for any other Sources

    To see all list of Source avaialble, please run `chid currency list`

Options:

  -to SOURCE_TO_FINAL_VALUE
  -from SOURCE_TO_BE_REFERANCE

      DESC
      self.arguments = ['-to', '-from']

        def run
          currency = CurrencyApi.convert(to: to, from: from)
          puts "1 #{from} is #{currency} #{to}"
        end

        def to
          options['-to']&.compact&.join || 'BRL'
        end

        def from
          options['-from']&.compact&.join || 'USD'
        end

      end
    end
  end
end
