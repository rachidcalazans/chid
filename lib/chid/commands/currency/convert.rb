module Chid
  module Commands
    module Currency
      class Convert < Command

        command :'currency convert'

        self.summary = 'You can convert an amount between types. Default -to BRL, -from USD'
        self.description = <<-DESC

Usage:

  $ chid currency convert -amount 10.5
    or
  $ chid currency convert -amount 10.5 -to BRL -from USD

    You can convert an amount between types. Default -to BRL, -from USD

    To see all list of Source avaialble, please run `chid currency list`

Options:

  -amount AMOUNT_TO_CONVERT
  -to SOURCE_TO_FINAL_VALUE
  -from SOURCE_TO_BE_REFERANCE

      DESC
      self.arguments = ['-amount', '-to', '-from']

        def run
          currency = CurrencyApi.convert(amount: amount, to: to, from: from)
          puts "Converted amount: #{amount} #{from} is #{currency} #{to}"
        end

        def amount
          options['-amount']&.compact.first.to_f|| 0.0
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
