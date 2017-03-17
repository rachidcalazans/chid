namespace :currency do

  desc 'You can convert an amount between types. Eg.: convert 10 USD to BRL'
  task :convert, [:amount, :from, :to] do |t, args|
    amount = CurrencyApi.convert(args)
    puts "The converted #{args[:from]} to #{args[:to]} is: #{amount}"
  end

end
