class YandexTranslateApi
  API_TOKEN = 'trnsl.1.1.20170318T165136Z.005f29f713d3e410.1d52e55d7e9a3f125e38645215a101e743b16b98'

  def self.translate(options = {})
    text = options.fetch(:text, "")
    from = options.fetch(:from, :en).to_sym
    to   = options.fetch(:to, :pt).to_sym

    uri = URI("https://translate.yandex.net/api/v1.5/tr.json/translate?lang=#{from}-#{to}&key=#{API_TOKEN}&text=#{text}")

    response = HTTP.get(uri)
    json     = JSON.parse response
    json['text'].first
  end

  def self.list
      puts "Language            Code    Language        Code".green
      puts "Azerbaijan          az      Maltese         mt"
      puts "Albanian            sq      Macedonian      mk"
      puts "Amharic             am      Maori           mi"
      puts "English             en      Marathi         mr"
      puts "Armenian            hy      Mongolian       mn"
      puts "Afrikaans           af      German          de"
      puts "Bashkir             ba      Norwegian       no"
      puts "Bulgarian           bg      Persian         fa"
      puts "Bosnian             bs      Polish          pl"
      puts "Welsh               cy      Portuguese      pt"
      puts "Vietnamese          vi      Russian         ru"
      puts "Italian             it      Telugu          te"
      puts "Spanish             es      Udmurt          udm"
      puts "Chinese             zh      French          fr"
      puts "Xhosa               xh      Croatian        hr"
      puts "Latin               la      Czech           cs"
      puts "Latvian             lv      Swedish         sv"
      puts "Lithuanian          lt      Scottish        gd"
      puts "Luxembourgish       lb      Estonian        et"
  end

end
