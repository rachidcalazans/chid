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

end
