#require 'http'

class CurrencyApi
  API_TOKEN = '61d0e853b52d82f00b393fdad228eb47'

  Quotes = Struct.new(:currency, :amount)

  # Reference Options: https://currency-api.appspot.com
  SOURCES = {
    ARS: 'Argentina Peso',
    AUD: 'Australia Dollar',
    BTC: 'Bitcoin',
    BRL: 'Brazil Real',
    CAD: 'Canada Dollar',
    CLP: 'Chile Peso',
    CNY: 'China Yuan Renminbi',
    CZK: 'Czech Republic Koruna',
    DKK: 'Denmark Krone',
    EUR: 'Euro Member Countries',
    FJD: 'Fiji Dollar',
    HNL: 'Honduras Lempira',
    HKD: 'Hong Kong Dollar',
    HUF: 'Hungary Forint',
    ISK: 'Iceland Krona',
    INR: 'India Rupee',
    IDR: 'Indonesia Rupiah',
    ILS: 'Israel Shekel',
    JPY: 'Japan Yen',
    KRW: 'Korea (South) Won',
    MYR: 'Malaysia Ringgit',
    MXN: 'Mexico Peso',
    NZD: 'New Zealand Dollar',
    NOK: 'Norway Krone',
    PKR: 'Pakistan Rupee',
    PHP: 'Philippines Peso',
    PLN: 'Poland Zloty',
    RUB: 'Russia Ruble',
    SGD: 'Singapore Dollar',
    ZAR: 'South Africa Rand',
    SEK: 'Sweden Krona',
    CHF: 'Switzerland Franc',
    TWD: 'Taiwan New Dollar',
    THB: 'Thailand Baht',
    TRY: 'Turkey Lira',
    GBP: 'United Kingdom Pound',
    USD: 'United States Dollar',
    VND: 'Viet Nam Dong'
  }

  def self.convert(options = {})
    amount = options.fetch(:amount, 1).to_f
    from   = options.fetch(:from, :USD).to_sym
    to     = options.fetch(:to, :BRL).to_sym

    request = HTTP.get("http://www.apilayer.net/api/live?access_key=#{API_TOKEN}")
    json    = JSON.parse request

    to_amount   = json['quotes']["USD#{to}"]
    from_amount = json['quotes']["USD#{from}"]

    if to == :USD
      amount / from_amount
    else
      to_amount * amount
    end
  end

end

