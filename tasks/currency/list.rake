namespace :currency do

  desc 'Show all types of currencies'
  task :list do
    types = CurrencyApi::SOURCES
    puts "Types available:\n\n"
    types.each { |k, v| puts "#{k} => #{v}"}
  end

end
