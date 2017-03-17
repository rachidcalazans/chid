namespace :currency do

  desc 'Get the current conversion for USD to BRL'
  task :current do
    currency = CurrencyApi.convert()
    puts "USD is #{currency} BRL"
  end

end


