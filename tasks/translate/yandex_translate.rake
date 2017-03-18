namespace :translate do
    desc 'Yandex translate'
    task :yandex_translate, [:text, :from, :to] do |t, args|
        puts "Translating..."
        text = YandexTranslateApi.translate(args)
        puts "#{text}".green
    end
end
