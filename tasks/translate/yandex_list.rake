namespace :translate do
    desc 'Yandex translate list'
    task :yandex_list do
        puts "All options availale are:".blue
        YandexTranslateApi.list
    end
end
